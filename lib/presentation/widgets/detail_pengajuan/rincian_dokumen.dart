import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/domain/entity/role/role.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_surat_rekomendasi_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_upload_scan_surat_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_verifikasi_berkas_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_verifikasi_lapangan_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/roles/role_provider.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_icon.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/input_uploadfile.dart';
import 'package:flutter_map_simtaru/utils/download_service.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class RincianDokumen extends HookConsumerWidget {
  const RincianDokumen({super.key, required this.pengajuan});

  final Pengajuan pengajuan;

  Future<void> _downloadFile(BuildContext context, String url) async {
    DownloadService downloadService = DownloadService(context: context);

    await downloadService.downloadFile(
      url: url,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleState = ref.watch(roleProvider);

    final uploadFileController = useState<File>(File(''));

    void handleUploadSurat(String tipeFile, String namaFile) async {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.custom,
        barrierDismissible: true,
        text: "Edit $namaFile ${pengajuan.nama_lengkap}",
        textAlignment: TextAlign.justify,
        confirmBtnText: 'Upload',
        cancelBtnText: 'Batal',
        showCancelBtn: true,
        widget: InputUploadFile(
          title: namaFile,
          pengajuan: pengajuan,
          fileController: uploadFileController,
        ),
        onConfirmBtnTap: () async {
          print(uploadFileController.value);
          if (uploadFileController.value.path != '') {
            Navigator.of(context).pop();
            context.loaderOverlay.show();

            try {
              final url = "${Endpoints.baseURL}${Endpoints.editFilePengajuan}${pengajuan.id}/$tipeFile";
              final data = FormData.fromMap(
                {
                  tipeFile: await MultipartFile.fromFile(uploadFileController.value.path),
                },
              );
              final Dio dio = Dio();

              await dio.post(url, data: data);

              uploadFileController.value = File('');

              ref.invalidate(pengajuanControllerProvider);
              ref.invalidate(pengajuanVerifikasiBerkasControllerProvider);
              ref.invalidate(pengajuanVerifikasiLapanganControllerProvider);
              ref.invalidate(pengajuanUploadScanSuratControllerProvider);
              ref.invalidate(pengajuanSuratRekomendasiControllerProvider);

              if (context.mounted) {
                context.loaderOverlay.hide();
                Flushbar(
                  message: "Berhasil Upload File",
                  backgroundColor: AppColors.greenColor,
                  duration: const Duration(seconds: 1),
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
                ).show(context).then((value) => context.pop());
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

    void handleDeleteSurat(String tipeFile) async {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: "Apakah anda yakin?",
        text: "File akan terhapus",
        cancelBtnText: "Batal",
        confirmBtnText: "Ya",
        confirmBtnColor: AppColors.redColor,
        onConfirmBtnTap: () async {
          Navigator.pop(context);

          context.loaderOverlay.show();

          try {
            final url = "${Endpoints.baseURL}${Endpoints.deleteFilePengajuan}${pengajuan.id}/$tipeFile";

            final Dio dio = Dio();

            await dio.post(url);

            ref.invalidate(pengajuanControllerProvider);
            ref.invalidate(pengajuanVerifikasiBerkasControllerProvider);
            ref.invalidate(pengajuanVerifikasiLapanganControllerProvider);
            ref.invalidate(pengajuanUploadScanSuratControllerProvider);
            ref.invalidate(pengajuanSuratRekomendasiControllerProvider);

            if (context.mounted) {
              context.loaderOverlay.hide();
              Flushbar(
                message: "Berhasil Hapus File",
                backgroundColor: AppColors.greenColor,
                duration: const Duration(seconds: 1),
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
              ).show(context).then((value) => context.pop());
            }
          } catch (e) {
            print("KONROL ${e.toString()}");

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
        },
      );
    }

    Widget checkFile(BuildContext context, String url, bool isAdmin, String namaFile, String tipeFile) {
      return Row(
        children: [
          url == ""
              ? const Text(
                  "Belum ada file",
                  style: TextStyle(
                    color: AppColors.greyColor,
                    fontSize: 12,
                  ),
                )
              : ButtonIcon(
                  icon: Icons.download_rounded,
                  onTap: () {
                    _downloadFile(context, url);
                  },
                ),
          const SizedBox(width: 10),
          !isAdmin
              ? const SizedBox()
              : ButtonIcon(
                  icon: Icons.edit,
                  onTap: () {
                    handleUploadSurat(
                      tipeFile,
                      namaFile,
                    );
                  },
                  bgColor: Colors.amber[700],
                ),
          const SizedBox(width: 10),
          !isAdmin
              ? const SizedBox()
              : ButtonIcon(
                  icon: Icons.delete,
                  onTap: () {
                    handleDeleteSurat(tipeFile);
                  },
                  bgColor: AppColors.redColor,
                ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(AppDouble.paddingInside),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppDouble.borderRadius),
        boxShadow: [
          AppStyles.boxShadowStyle,
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          "Dokumen",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(),
        const Text(
          "Fotocopy KTP",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(
          context,
          pengajuan.fotocopy_ktp.toString(),
          roleState is! User,
          "Fotocopy KTP",
          "fotocopy_ktp",
        ),
        const SizedBox(height: 10),
        const Text(
          "Fotocopy Sertifikat",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(context, pengajuan.fotocopy_sertifikat.toString(), roleState is! User, "Fotocopy Sertifikat",
            "fotocopy_sertifikat"),
        const SizedBox(height: 10),
        const Text(
          "Fotocopy SPPT PBB",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(
          context,
          pengajuan.fotocopy_sppt_pbb.toString(),
          roleState is! User,
          "Fotocopy SPPT PBB",
          "fotocopy_sppt_pbb",
        ),
        const SizedBox(height: 10),
        const Text(
          "Fotocopy NPWP",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(
          context,
          pengajuan.fotocopy_npwp.toString(),
          roleState is! User,
          "Fotocopy NPWP",
          "fotocopy_npwp",
        ),
        const SizedBox(height: 10),
        const Text(
          "Surat Persetujuan Tetangga",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(
          context,
          pengajuan.surat_persetujuan_tetangga.toString(),
          roleState is! User,
          "Surat Persetujuan Tetangga",
          "surat_persetujuan_tetangga",
        ),
        const SizedBox(height: 10),
        const Text(
          "Gambar Rencana Pembangunan",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        pengajuan.gambar_rencana_pembangunan?.isEmpty ?? true
            ? Row(
                children: [
                  const Text(
                    "Belum ada file",
                    style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ButtonIcon(
                    icon: Icons.edit,
                    onTap: () {},
                    bgColor: Colors.amber[700],
                  ),
                  const SizedBox(width: 10),
                  ButtonIcon(
                    icon: Icons.delete,
                    onTap: () {},
                    bgColor: AppColors.redColor,
                  ),
                ],
              )
            : Column(
                children: pengajuan.gambar_rencana_pembangunan
                        ?.map(
                          (e) => Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  ButtonIcon(
                                    icon: Icons.download_rounded,
                                    onTap: () {
                                      _downloadFile(context, e);
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  roleState is! User
                                      ? ButtonIcon(
                                          icon: Icons.edit,
                                          onTap: () {},
                                          bgColor: Colors.amber[700],
                                        )
                                      : const SizedBox(),
                                  const SizedBox(width: 10),
                                  roleState is! User
                                      ? ButtonIcon(
                                          icon: Icons.delete,
                                          onTap: () {},
                                          bgColor: AppColors.redColor,
                                        )
                                      : const SizedBox()
                                ],
                              )
                            ],
                          ),
                        )
                        .toList() ??
                    [],
              ),
        const SizedBox(height: 10),
        const Text(
          "Fotocopy Akte Pendirian Perusahaan",
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(
          context,
          pengajuan.fotocopy_akte_pendirian_perusahaan.toString(),
          roleState is! User,
          "Fotocopy Akte Pendirian Perusahaan",
          "fotocopy_akte_pendirian_perusahaan",
        ),
        const SizedBox(height: 10),
        const Text(
          "Set Lokasi Bangunan",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(
          context,
          pengajuan.set_lokasi_bangunan.toString(),
          roleState is! User,
          "Set Lokasi Bangunan",
          "set_lokasi_bangunan",
        ),
        const SizedBox(height: 10),
        const Text(
          "Surat Pernyataan Force Majeur",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(
          context,
          pengajuan.surat_pernyataan_force_majeur.toString(),
          roleState is! User,
          "Surat Pernyataan Force Majeur",
          "surat_pernyataan_force_majeur",
        ),
        const SizedBox(height: 10),
        const Text(
          "Proposal",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(
          context,
          pengajuan.proposal.toString(),
          roleState is! User,
          "Proposal",
          "proposal",
        ),
        const SizedBox(height: 10),
        pengajuan.status_id! > 2
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  pengajuan.status_id! > 3
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Scan Surat Hasil Rekomendasi",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            checkFile(
                              context,
                              pengajuan.scan_surat_hasil_rekomendasi.toString(),
                              roleState is! User,
                              "Scan Surat Hasil Rekomendasi",
                              "scan_surat_hasil_rekomendasi",
                            ),
                          ],
                        )
                      : const SizedBox()
                ],
              )
            : const SizedBox(),
      ]),
    );
  }
}
