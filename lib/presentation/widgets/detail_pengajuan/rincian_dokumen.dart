import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/domain/entity/role/role.dart';
import 'package:flutter_map_simtaru/presentation/controllers/roles/role_provider.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_icon.dart';
import 'package:flutter_map_simtaru/utils/download_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RincianDokumen extends HookConsumerWidget {
  const RincianDokumen({super.key, required this.pengajuan});

  final Pengajuan pengajuan;

  Future<void> _downloadFile(BuildContext context, String url) async {
    DownloadService downloadService = DownloadService(context: context);

    await downloadService.downloadFile(
      url: url,
    );
  }

  Widget checkFile(BuildContext context, String url, bool isAdmin) {
    if (url == "") {
      return Row(
        children: [
          const Text(
            "Belum ada file",
            style: TextStyle(
              color: AppColors.greyColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 10),
          !isAdmin
              ? const SizedBox()
              : ButtonIcon(
                  icon: Icons.edit,
                  onTap: () {},
                  bgColor: Colors.amber[700],
                ),
          const SizedBox(width: 10),
          !isAdmin
              ? const SizedBox()
              : ButtonIcon(
                  icon: Icons.delete,
                  onTap: () {},
                  bgColor: AppColors.redColor,
                ),
        ],
      );
    } else {
      return Row(
        children: [
          ButtonIcon(
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
                    print(isAdmin);
                  },
                  bgColor: Colors.amber[700],
                ),
          const SizedBox(width: 10),
          !isAdmin
              ? const SizedBox()
              : ButtonIcon(
                  icon: Icons.delete,
                  onTap: () {},
                  bgColor: AppColors.redColor,
                ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleState = ref.watch(roleProvider);

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
        checkFile(context, pengajuan.fotocopy_ktp.toString(), roleState is Admin),
        const SizedBox(height: 10),
        const Text(
          "Fotocopy Sertifikat",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(context, pengajuan.fotocopy_sertifikat.toString(), roleState is Admin),
        const SizedBox(height: 10),
        const Text(
          "Fotocopy SPPT PBB",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(context, pengajuan.fotocopy_sppt_pbb.toString(), roleState is Admin),
        const SizedBox(height: 10),
        const Text(
          "Fotocopy NPWP",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(context, pengajuan.fotocopy_npwp.toString(), roleState is Admin),
        const SizedBox(height: 10),
        const Text(
          "Surat Persetujuan Tetangga",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(context, pengajuan.surat_persetujuan_tetangga.toString(), roleState is Admin),
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
                                  roleState is Admin
                                      ? ButtonIcon(
                                          icon: Icons.edit,
                                          onTap: () {},
                                          bgColor: Colors.amber[700],
                                        )
                                      : const SizedBox(),
                                  const SizedBox(width: 10),
                                  roleState is Admin
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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(context, pengajuan.fotocopy_akte_pendirian_perusahaan.toString(), roleState is Admin),
        const SizedBox(height: 10),
        const Text(
          "Set Lokasi Bangunan",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(context, pengajuan.set_lokasi_bangunan.toString(), roleState is Admin),
        const SizedBox(height: 10),
        const Text(
          "Surat Pernyataan Force Majeur",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(context, pengajuan.surat_pernyataan_force_majeur.toString(), roleState is Admin),
        const SizedBox(height: 10),
        const Text(
          "Proposal",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        checkFile(context, pengajuan.proposal.toString(), roleState is Admin),
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
                            checkFile(context, pengajuan.scan_surat_hasil_rekomendasi.toString(), roleState is Admin),
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
