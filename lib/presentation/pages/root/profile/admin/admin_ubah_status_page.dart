import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_action_pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_search_pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/bottom_sheet_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/item_pengajuan_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/loading/item_pengajuan_loading.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/warning_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/input_dropdown_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AdminUbahStatusPage extends HookConsumerWidget {
  const AdminUbahStatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = useState<int>(-1);
    final showScrollToTop = useState(false);
    final hasReachedMax = useState(false);
    final pengajuanState = ref.watch(pengajuanControllerProvider);

    final scrollController = ScrollController();

    scrollController.addListener(
      () {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          final newValue = ref.read(pengajuanControllerProvider.notifier).loadMore();

          newValue.then((value) => hasReachedMax.value = value);
        }

        if (scrollController.position.pixels >= 100) {
          showScrollToTop.value = true;
        } else {
          showScrollToTop.value = false;
        }
      },
    );

    void handleUbahStatus(String nama, String idPengajuan, Pengajuan pengajuan) async {
      context.pop();

      QuickAlert.show(
        context: context,
        type: QuickAlertType.custom,
        barrierDismissible: true,
        title: "Ubah status atas nama pengajuan $nama",
        textAlignment: TextAlign.justify,
        confirmBtnText: 'Ya',
        cancelBtnText: 'Batal',
        showCancelBtn: true,
        widget: InputDropDownMenu(title: "Pilih Status", pengajuan: pengajuan, inputController: inputController),
        onConfirmBtnTap: () async {
          Navigator.of(context).pop();
          context.loaderOverlay.show();
          try {
            final url = Endpoints.baseURL + Endpoints.updateStatusPengajuan + idPengajuan;
            final Dio dio = Dio();

            await dio.put(
              url,
              data: {
                "status_id": inputController.value,
              },
              // options: Options(
              //   headers: {
              //     "Accept": "application/json",
              //     "Authorization": "Bearer ${ref.read(tokenProvider).state}",
              //   },
              // ),
            );

            await ref.refresh(pengajuanControllerProvider.notifier).getPengajuan();
            if (context.mounted) {
              context.loaderOverlay.hide();
              Flushbar(
                message: "Berhasil ubah status",
                backgroundColor: AppColors.greenColor,
                duration: const Duration(seconds: 3),
                flushbarPosition: FlushbarPosition.TOP,
                flushbarStyle: FlushbarStyle.FLOATING,
                animationDuration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(8),
                isDismissible: true,
                shouldIconPulse: false,
                icon: const Icon(
                  Icons.check,
                  color: AppColors.whiteColor,
                ),
              ).show(context);
            }
          } catch (e) {
            if (context.mounted) {
              context.loaderOverlay.hide();
              Flushbar(
                message: "Gagal ubah status",
                backgroundColor: AppColors.redColor,
                duration: const Duration(seconds: 3),
                flushbarPosition: FlushbarPosition.TOP,
                flushbarStyle: FlushbarStyle.FLOATING,
                animationDuration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(8),
                isDismissible: true,
                shouldIconPulse: false,
                icon: const Icon(
                  Icons.close,
                  color: AppColors.whiteColor,
                ),
              ).show(context);
            }
          } finally {
            if (context.mounted) {
              context.loaderOverlay.hide();
            }
          }
        },
      );
    }

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
        appBar: AppBar(
          title: const Text("Admin Ubah Status"),
        ),
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
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
                  const WarningCard(),
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
                                        actions: [
                                          ButtonActionPengajuan(
                                            label: "Ubah Status",
                                            icon: Icons.edit,
                                            color: AppColors.mapColorStatusChip[2]!,
                                            onTap: () {
                                              handleUbahStatus(
                                                data[index].nama_lengkap!,
                                                data[index].id.toString(),
                                                data[index],
                                              );
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
    );
  }
}
