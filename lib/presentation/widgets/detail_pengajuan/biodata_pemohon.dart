import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';

class BiodataPemohon extends StatelessWidget {
  const BiodataPemohon({super.key, required this.pengajuan});

  final Pengajuan pengajuan;

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
            "Biodata Pemohon",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(
            color: AppColors.borderColor,
          ),
          const Text(
            "Nama",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Text(
            pengajuan.nama_lengkap.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "No Identitas",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Text(
            pengajuan.no_identitas.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "Alamat",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Text(
            pengajuan.alamat.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "Tempat Tanggal Lahir",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Text(
            pengajuan.tempat_tanggal_lahir.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "Pekerjaan",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Text(
            pengajuan.pekerjaan.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "No HP",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Text(
            pengajuan.no_hp.toString(),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
