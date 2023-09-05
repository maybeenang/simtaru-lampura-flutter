import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';

class RincianDokumen extends StatelessWidget {
  const RincianDokumen({super.key});

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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dokumen",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          Text(
            "Fotocopy KTP",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Fotocopy Sertifikat",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Fotocopy SPPT PBB",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Fotocopy NPWP",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Surat Persetujuan Tetangga",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Gambar Rencana Pembangunan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Set Lokasi Bangunan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Surat Pernyataan Force Majeur",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Proposal",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Surat Pernyataan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Surat Permohonan SKPR",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Surat Permohonan TKPRD",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Berita Acara",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Dokumentasi",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Nota Dinas",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Surat Hasil Rekomendasi",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Scan Surat Hasil Rekomendasi",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
