import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/detail_pengajuan/minimap_koordinat.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class RencanaPembangunan extends StatelessWidget {
  const RencanaPembangunan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rencana Pembangunan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          Text(
            "Letak Tanah",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "Dusun Cendrawasih RT/RK 002/001, Desa Semuli Jaya, Kecamatan Abung Semuli, Kabupaten Lampung Utara",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Rencana Penggunaan Tanah",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "Kantor dan Gudang",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Batas Sebelah Utara",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "Tanah Milik an. Rangga",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Batas Sebelah Timur",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "Tanah Milik an. Jujun",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Batas Sebelah Selatan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "Tanah Milik An. Neneng",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Batas Sebelah Barat",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "Tanah Milik An. Subekti",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Titik Koordinat",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-4.655018,104.738142",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          MinimapKoordinat(),
        ],
      ),
    );
  }
}
