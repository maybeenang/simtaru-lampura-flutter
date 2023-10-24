import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/domain/entity/role/role.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_provider.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_upload_scan_surat_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_user_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_verifikasi_berkas_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_verifikasi_lapangan_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/roles/role_provider.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_search_pengajuan.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/carousel_pengajuan_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/item_pengajuan_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/loading/item_pengajuan_loading.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_appbar_fitur.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OverviewPengajuanPage extends HookConsumerWidget {
  const OverviewPengajuanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showScrollToTop = useState(false);
    final hasReachedMax = useState(false);
    final roleState = ref.watch(roleProvider);
    final pengajuanState = ref.watch(pengajuanProviderProvider);
    //     roleState is Admin ? ref.watch(pengajuanControllerProvider) : ref.watch(pengajuanUserControllerProvider);
    // ref.watch(statusPengajuanControllerProvider);

    final scrollController = ScrollController();

    Future<bool> loadMore() async {
      if (roleState is Admin) {
        return await ref.read(pengajuanControllerProvider.notifier).loadMore();
      } else if (roleState is AdminVerifBerkas) {
        return await ref.read(pengajuanVerifikasiBerkasControllerProvider.notifier).loadMore();
      } else if (roleState is AdminVerifLapangan) {
        return await ref.read(pengajuanVerifikasiLapanganControllerProvider.notifier).loadMore();
      } else if (roleState is AdminUploadScanSurat) {
        return await ref.read(pengajuanUploadScanSuratControllerProvider.notifier).loadMore();
      } else {
        return await ref.read(pengajuanUserControllerProvider.notifier).loadMore();
      }
    }

    Future refresh() async {
      print(roleState);
      hasReachedMax.value = false;
      if (roleState is Admin) {
        await ref.refresh(pengajuanControllerProvider.notifier).getPengajuan();
      } else if (roleState is AdminVerifBerkas) {
        await ref.refresh(pengajuanVerifikasiBerkasControllerProvider.notifier).getPengajuan();
      } else if (roleState is AdminVerifLapangan) {
        await ref.refresh(pengajuanVerifikasiLapanganControllerProvider.notifier).getPengajuan();
      } else if (roleState is AdminUploadScanSurat) {
        await ref.refresh(pengajuanUploadScanSuratControllerProvider.notifier).getPengajuan();
      } else {
        await ref.refresh(pengajuanUserControllerProvider.notifier).getPengajuan();
      }
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        final newValue = loadMore();
        newValue.then((value) => hasReachedMax.value = value);
      }

      if (scrollController.position.pixels >= 100) {
        showScrollToTop.value = true;
      } else {
        showScrollToTop.value = false;
      }
    });

    return Scaffold(
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
          await refresh();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const CustomAppBarFitur(
                    title: "Pengajuan",
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
                  roleState is User ? const SizedBox() : const CarouselPengajuanCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            pengajuanState.maybeWhen(
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
                if (data!.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text("Tidak ada pengajuan"),
                    ),
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
              child: SizedBox(height: 20),
            )
          ],
        ),
      ),
    );
  }
}
