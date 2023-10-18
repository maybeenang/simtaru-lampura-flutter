import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_icon.dart';
import 'package:flutter_map_simtaru/utils/download_service.dart';

class RincianDokumen extends StatelessWidget {
  const RincianDokumen({super.key, required this.pengajuan});

  final Pengajuan pengajuan;

  Future<void> _downloadFile(BuildContext context, String url) async {
    DownloadService downloadService = DownloadService(context: context);

    await downloadService.downloadFile(
      url: url,
    );
  }

  Widget checkFile(BuildContext context, String url) {
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          checkFile(context, pengajuan.fotocopy_ktp.toString()),
          const SizedBox(height: 10),
          const Text(
            "Fotocopy Sertifikat",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          checkFile(context, pengajuan.fotocopy_sertifikat.toString()),
          const SizedBox(height: 10),
          const Text(
            "Fotocopy SPPT PBB",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          checkFile(context, pengajuan.fotocopy_sppt_pbb.toString()),
          const SizedBox(height: 10),
          const Text(
            "Fotocopy NPWP",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          checkFile(context, pengajuan.fotocopy_npwp.toString()),
          const SizedBox(height: 10),
          const Text(
            "Surat Persetujuan Tetangga",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          checkFile(context, pengajuan.surat_persetujuan_tetangga.toString()),
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
          checkFile(context, pengajuan.fotocopy_akte_pendirian_perusahaan.toString()),
          const SizedBox(height: 10),
          const Text(
            "Set Lokasi Bangunan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          checkFile(context, pengajuan.set_lokasi_bangunan.toString()),
          const SizedBox(height: 10),
          const Text(
            "Surat Pernyataan Force Majeur",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          checkFile(context, pengajuan.surat_pernyataan_force_majeur.toString()),
          const SizedBox(height: 10),
          const Text(
            "Proposal",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          checkFile(context, pengajuan.proposal.toString()),
          const SizedBox(height: 10),
          const Text(
            "Surat Pernyataan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          checkFile(context, pengajuan.surat_pernyataan.toString()),
          const SizedBox(height: 10),
          const Text(
            "Surat Permohonan SKPR",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          checkFile(context, pengajuan.surat_permohonan_skpr.toString()),
          const SizedBox(height: 10),
          const Text(
            "Surat Permohonan TKPRD",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          checkFile(context, pengajuan.surat_permohonan_tkprd.toString()),
          const SizedBox(height: 10),
          const Text(
            "Berita Acara",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          checkFile(context, pengajuan.berita_acara.toString()),
          const SizedBox(height: 10),
          const Text(
            "Dokumentasi",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          checkFile(context, pengajuan.file_dokumentasi.toString()),
          const SizedBox(height: 10),
          const Text(
            "Nota Dinas",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          checkFile(context, pengajuan.nota_dinas.toString()),
          const SizedBox(height: 10),
          const Text(
            "Surat Hasil Rekomendasi",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          checkFile(context, pengajuan.surat_hasil_rekomendasi.toString()),
          const SizedBox(height: 10),
          const Text(
            "Scan Surat Hasil Rekomendasi",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          checkFile(context, pengajuan.scan_surat_hasil_rekomendasi.toString()),
        ],
      ),
    );
  }
}
