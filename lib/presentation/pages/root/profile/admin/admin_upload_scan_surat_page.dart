import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_upload_scan_surat_controller.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_search_pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/item_pengajuan_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/loading/item_pengajuan_loading.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_appbar_fitur.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminUploadScanSuratPage extends HookConsumerWidget {
  const AdminUploadScanSuratPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showScrollToTop = useState(false);
    final hasReachedMax = useState(false);
    final pengajuanUploadScanSuratState = ref.watch(pengajuanUploadScanSuratControllerProvider);

    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        final newValue = ref.read(pengajuanUploadScanSuratControllerProvider.notifier).loadMore();

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
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const CustomAppBarFitur(
                    title: "Admin Upload Scan Surat",
                    bgColor: AppColors.primaryColor,
                    labelColor: AppColors.whiteColor,
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
            pengajuanUploadScanSuratState.maybeWhen(
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
    );
  }
}
