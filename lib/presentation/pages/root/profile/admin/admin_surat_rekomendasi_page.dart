import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/domain/entity/role/role.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_surat_rekomendasi_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/roles/role_provider.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_action_pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_search_pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/bottom_sheet_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/item_pengajuan_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/loading/item_pengajuan_loading.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminSuratRekomendasiPage extends HookConsumerWidget {
  const AdminSuratRekomendasiPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showScrollToTop = useState(false);
    final hasReachedMax = useState(false);
    final pengajuanSuratRekomendasiState = ref.watch(pengajuanSuratRekomendasiControllerProvider);
    final roleState = ref.watch(roleProvider);

    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        final newValue = ref.read(pengajuanSuratRekomendasiControllerProvider.notifier).loadMore();

        newValue.then((value) => hasReachedMax.value = value);
      }

      if (scrollController.position.pixels >= 100) {
        showScrollToTop.value = true;
      } else {
        showScrollToTop.value = false;
      }
    });

    return CustomSafeArea(
      child: Scaffold(
        floatingActionButton: showScrollToTop.value
            ? Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: FloatingActionButton(
                  onPressed: () {
                    scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  backgroundColor: AppColors.primaryColor,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.arrow_upward,
                    color: AppColors.whiteColor,
                  ),
                ),
              )
            : null,
        body: RefreshIndicator(
          onRefresh: () async {
            await ref.refresh(pengajuanSuratRekomendasiControllerProvider.notifier).getPengajuan();
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    AppBar(
                      title: const Text("Admin Surat Rekomendasi"),
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
                        const ButtonSearchPengajuan(),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              pengajuanSuratRekomendasiState.maybeWhen(
                orElse: () {
                  return SliverList.separated(
                    itemCount: 5,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppDouble.paddingOutside),
                        child: ItemPengajuanLoading(),
                      );
                    },
                  );
                },
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(
                      child: Text("Tidak ada data"),
                    );
                  }

                  return SliverList.separated(
                    itemCount: hasReachedMax.value
                        ? data.length
                        : data.length > 5
                            ? data.length + 3
                            : data.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDouble.paddingOutside,
                        ),
                        child: index >= data.length
                            ? const ItemPengajuanLoading()
                            : ItemPengajuanCard(
                                pengajuan: data[index],
                                onTap: () {
                                  Future.delayed(
                                    const Duration(milliseconds: 100),
                                    () => showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return BottomSheetCard(
                                          pengajuan: data[index],
                                          actions: roleState is! Surveyor
                                              ? [
                                                  ButtonActionPengajuan(
                                                    label: "Edit Polygon",
                                                    icon: Icons.map,
                                                    color: AppColors.greenColor,
                                                    onTap: () {
                                                      context.pop();
                                                      AdminRekamPolygonRoute(data[index]).push(context);
                                                    },
                                                  ),
                                                ]
                                              : [
                                                  ButtonActionPengajuan(
                                                    label: "Tambah Catatan",
                                                    icon: Icons.note_add,
                                                    color: AppColors.pengajuandiProses,
                                                    onTap: () {
                                                      context.pop();
                                                      AdminSurveyorTambahCatatanRoute(data[index]).push(context);
                                                    },
                                                  ),
                                                  const SizedBox(height: 5),
                                                  ButtonActionPengajuan(
                                                    label: "Lihat Catatan",
                                                    icon: Icons.note,
                                                    color: AppColors.greenColor,
                                                    onTap: () {
                                                      context.pop();
                                                      AdminSurveyorLihatCatatanRoute(data[index]).push(context);
                                                    },
                                                  ),
                                                  const SizedBox(height: 5),
                                                  ButtonActionPengajuan(
                                                    label: "Lihat Polygon",
                                                    icon: Icons.map,
                                                    color: AppColors.greenColor,
                                                    onTap: () {
                                                      context.pop();
                                                      AdminRekamPolygonRoute(data[index]).push(context);
                                                    },
                                                  ),
                                                ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                      );
                    },
                  );
                },
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 50),
              )
            ],
          ),
        ),
      ),
    );
  }
}
