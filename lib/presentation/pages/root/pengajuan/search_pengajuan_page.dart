import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/role/role.dart';
import 'package:flutter_map_simtaru/presentation/controllers/roles/role_provider.dart';
import 'package:flutter_map_simtaru/presentation/controllers/status_pengajuan_controller.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/loading/item_pengajuan_loading.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPengajuanPage extends HookConsumerWidget {
  const SearchPengajuanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectItem = useState(0);
    final statusPengajuan = ref.watch(statusPengajuanControllerProvider);
    final roleState = ref.watch(roleProvider);
    final filterStatusPengajuan = statusPengajuan.when(
      data: (data) {
        return data
            .where(
              (element) =>
                  element.id == 1 || element.id == 2 || element.id == 3 || element.id == 11 || element.id == 12,
            )
            .toList();
      },
      error: (error, stackTrace) {
        return [];
      },
      loading: () {
        return [];
      },
    );
    return CustomSafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      "Cari Pengajuan",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    color: AppColors.primaryColor,
                    child: const SizedBox(
                      width: double.infinity,
                      height: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          AppStyles.boxShadowStyle,
                        ],
                      ),
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.whiteColor,
                          hintText: "Cari berdasarkan nama",
                          contentPadding: const EdgeInsets.all(10),
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              roleState is Admin
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Filter",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            spacing: 10,
                            children: [
                              ChoiceChip(
                                label: const Text(
                                  "Semua",
                                ),
                                selectedColor: AppColors.primaryColor,
                                labelStyle: TextStyle(
                                  color: selectItem.value == 0 ? AppColors.whiteColor : AppColors.greyColor,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                showCheckmark: false,
                                selected: selectItem.value == 0,
                                onSelected: (bool selected) {
                                  selectItem.value = selected ? 0 : 0;
                                },
                              ),
                              ...filterStatusPengajuan.map(
                                (e) {
                                  return ChoiceChip(
                                    label: Text(
                                      e.jenis_status,
                                    ),
                                    selectedColor: AppColors.primaryColor,
                                    labelStyle: TextStyle(
                                      color: selectItem.value == e.id ? AppColors.whiteColor : AppColors.greyColor,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    showCheckmark: false,
                                    selected: selectItem.value == e.id,
                                    onSelected: (bool selected) {
                                      selectItem.value = selected ? e.id : 0;
                                    },
                                  );
                                },
                              ).toList(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    )
                  : const SizedBox(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(),
              ),
              ListView.separated(
                padding: const EdgeInsetsDirectional.all(10),
                itemBuilder: (context, index) {
                  return const ItemPengajuanLoading();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
