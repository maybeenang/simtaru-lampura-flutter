import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:intl/intl.dart';

class DataLapangan extends StatelessWidget {
  const DataLapangan({super.key, required this.pengajuan});

  final Pengajuan pengajuan;

  Widget CustomDivider({required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.secondaryColor,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
    );
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
            "Data Lapangan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(
            color: AppColors.borderColor,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tanggal Peninjauan Lokasi",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                DateFormat('yyyy-MM-dd').format(DateTime.parse(pengajuan.tanggal_peninjauan_lokasi!)),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              CustomDivider(text: "Letak Tanah"),
              const SizedBox(height: 10),
              const Text(
                "Desa",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.desa!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Kecamatan",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.kecamatan!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Batas Sebelah Utara",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.batas_sebelah_utara!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Batas Sebelah Timur",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.batas_sebelah_timur!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Batas Sebelah Selatan",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.batas_sebelah_selatan!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Batas Sebelah Barat",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.batas_sebelah_barat!,
              ),
              const SizedBox(height: 10),
              CustomDivider(text: "Letak Dimohon"),
              const SizedBox(height: 10),
              const Text(
                "Penggunaan Tanah Saat Dimohon",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.penggunaan_tanah_saat_dimohon!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Topografi Tanah",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.topografi_tanah!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Rencana Penggunaan Tanah",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.rencana_penggunaan_tanah!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Kesuburan Tanah",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.kesuburan_tanah!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Sarana Irigasi atau Sumur Bor",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.sarana_irigasi_atau_sumurbor!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Jarak Bangunan dengan Sungai",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.jarak_bangunan_dengan_sungai!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Jarak Bangunan dengan Jalan",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.jarak_bangunan_dengan_jalan!,
              ),
              const SizedBox(height: 10),
              CustomDivider(text: "Status Tanah"),
              const SizedBox(height: 10),
              const Text(
                "Status Kepemilikan",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.status_kepemilikan!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Bukti Penguasaan Tanah",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.bukti_penguasaan_tanah!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Luas Tanah Seluruhnya",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.luas_tanah_seluruhnya!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Luas Tanah Yang Dimohon",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.luas_tanah_yang_dimohon!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Luas Tanah Yang Disetujui",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.luas_tanah_yang_disetujui!,
              ),
              const SizedBox(height: 10),
              CustomDivider(text: "Keputusan"),
              const SizedBox(height: 10),
              const Text(
                "Kesesuaian Rencana",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.kesesuaian_rencana!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Hubungan Pemohon dengan Tanah",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.hubungan_pemohon_dengan_tanah!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Kesesuaian dengan Keadaan Fisik Tanah",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.kesesuaian_dengan_keadaan_fisik_tanah!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Tanah yang Dimohon Fisiknya",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.tanah_yang_dimohon_fisiknya!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Jarak dari Pemukiman Terdekat",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.jarak_dari_pemukiman_terdekat!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Pertimbangan",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.pertimbangan!,
              ),
              const SizedBox(height: 10),
              CustomDivider(text: "Intensitas Pemanfaatan Ruang"),
              const SizedBox(height: 10),
              const Text(
                "Luas Bangunan",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.luas_bangunan!,
              ),
              const SizedBox(height: 10),
              const Text(
                "Tinggi Bangunan",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.tinggi_bangunan!,
              ),
              const SizedBox(height: 10),
              const Text(
                "KDB",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.kdb!,
              ),
              const SizedBox(height: 10),
              const Text(
                "KLB",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.klb!,
              ),
              const SizedBox(height: 10),
              const Text(
                "KDH",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.kdh!,
              ),
              const SizedBox(height: 10),
              const Text(
                "GSB",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                pengajuan.gsb!,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
