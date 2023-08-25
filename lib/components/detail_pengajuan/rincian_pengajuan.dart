import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class RincianPengajuan extends StatelessWidget {
  const RincianPengajuan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Rincian Pengajuan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          const Text(
            "Status",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            child: const Text(
              "Verifikasi Lapangan",
              style: TextStyle(fontSize: 14, color: AppColors.whiteColor),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Bertindak Atas Nama",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Text(
            "PT.KEMBAR KECANA PRATAMA",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "Penggunaan Tanah Saat Dimohon",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Text(
            "Tanah Perkarangan",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "Luas Tanah Seluruhnya",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Text(
            "367 m2",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "Luas Tanah Yang Dimohon",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Text(
            "84.8 m2",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "Bukti Penguasaan Tanah",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Text(
            "Sertipikat Hak Milik No.01195 An. Griselda Anada Tanggal Pembukuan",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
