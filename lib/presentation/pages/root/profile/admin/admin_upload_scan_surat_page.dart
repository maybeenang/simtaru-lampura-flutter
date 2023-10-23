import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_upload_scan_surat_controller.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_action_pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_search_pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/bottom_sheet_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/item_pengajuan_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/loading/item_pengajuan_loading.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_appbar_fitur.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/input_uploadfile.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AdminUploadScanSuratPage extends HookConsumerWidget {
  const AdminUploadScanSuratPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadFileController = useState(File(''));
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

    void handleUploadSurat(String nama, String idPengajuan, Pengajuan pengajuan) async {
      context.pop();

      QuickAlert.show(
        context: context,
        type: QuickAlertType.custom,
        barrierDismissible: true,
        text: "Upload Surat Hasil rekomendasi yang sudah ditandatangani atas nama pengajuan $nama",
        textAlignment: TextAlign.justify,
        confirmBtnText: 'Upload',
        cancelBtnText: 'Batal',
        showCancelBtn: true,
        widget: InputUploadFile(
          title: "Scan Surat Hasil Rekomendasi",
          pengajuan: pengajuan,
          fileController: uploadFileController,
        ),
        onConfirmBtnTap: () async {
          print(uploadFileController.value);
          if (uploadFileController.value.path != '') {
            Navigator.of(context).pop();
            context.loaderOverlay.show();

            try {
              final url =
                  "${Endpoints.baseURL}${Endpoints.editFilePengajuan}${pengajuan.id}/scan_surat_hasil_rekomendasi";
              final data = FormData.fromMap(
                {
                  "scan_surat_hasil_rekomendasi": await MultipartFile.fromFile(uploadFileController.value.path),
                },
              );
              final Dio dio = Dio();

              await dio.post(url, data: data);

              String urlUpdateStatus = "${Endpoints.baseURL}${Endpoints.updateStatusPengajuan}${pengajuan.id}";

              await dio.put(
                urlUpdateStatus,
                data: {
                  "status_id": 12,
                },
              );

              ref.invalidate(pengajuanUploadScanSuratControllerProvider);
              uploadFileController.value = File('');

              if (context.mounted) {
                context.loaderOverlay.hide();
                Flushbar(
                  message: "Berhasil Upload File",
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
              print("KONROL ${e.toString()}");
              uploadFileController.value = File('');

              if (context.mounted) {
                context.loaderOverlay.hide();
                Flushbar(
                  message: "Terjadi Kesalahan",
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
                    Icons.delete,
                    color: AppColors.whiteColor,
                  ),
                ).show(context);
              }
            } finally {
              if (context.mounted) {
                context.loaderOverlay.hide();
              }
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
        body: RefreshIndicator(
          onRefresh: () async {
            ref.read(pengajuanUploadScanSuratControllerProvider.notifier).getPengajuan();
          },
          child: CustomScrollView(
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
                                              label: "Upload Surat",
                                              icon: Icons.upload_file,
                                              color: AppColors.secondaryColor,
                                              onTap: () {
                                                handleUploadSurat(
                                                    data[index].nama_lengkap!, data[index].id.toString(), data[index]);
                                              },
                                            ),
                                            const SizedBox(height: 5),
                                            ButtonActionPengajuan(
                                              label: "Edit Polygon",
                                              icon: Icons.map,
                                              color: AppColors.greenColor,
                                              onTap: () {
                                                context.pop();
                                                AdminRekamPolygonRoute(data[index]).push(context);
                                              },
                                            ),
                                            const SizedBox(height: 5),
                                            ButtonActionPengajuan(
                                              label: "Edit",
                                              icon: Icons.edit,
                                              color: AppColors.mapColorStatusChip[2]!,
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
