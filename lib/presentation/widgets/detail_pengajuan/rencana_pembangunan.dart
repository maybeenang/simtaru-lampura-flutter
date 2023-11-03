import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class RencanaPembangunan extends StatelessWidget {
  const RencanaPembangunan({super.key, required this.pengajuan});

  final Pengajuan pengajuan;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDouble.paddingInside),
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
            "Rencana Pembangunan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            color: AppColors.borderColor,
          ),
          const Text(
            "Letak Tanah",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            pengajuan.letak_tanah.toString(),
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Rencana Penggunaan Tanah",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            pengajuan.rencana_penggunaan_tanah.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "Batas Sebelah Utara",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            pengajuan.batas_sebelah_utara.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "Batas Sebelah Timur",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            pengajuan.batas_sebelah_timur.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "Batas Sebelah Selatan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            pengajuan.batas_sebelah_selatan.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "Batas Sebelah Barat",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            pengajuan.batas_sebelah_barat.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                "Titik Koordinat",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextButton(
                onPressed: () {
                  final Uri uri =
                      Uri.parse("https://www.google.com/maps/search/?api=1&query=${pengajuan.titik_koordinat}");
                  launchUrl(uri);
                },
                child: const Text(
                  "Lihat Peta",
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
          Text(
            pengajuan.titik_koordinat.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          // const SizedBox(height: 10),
          // Container(
          //   clipBehavior: Clip.antiAlias,
          //   decoration: BoxDecoration(
          //     color: AppColors.greyColor,
          //     borderRadius: BorderRadius.circular(AppDouble.borderRadius),
          //   ),
          //   child: const MinimapKoordinat(),
          // ),
        ],
      ),
    );
  }
}
