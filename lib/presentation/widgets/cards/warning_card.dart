import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';

class WarningCard extends StatelessWidget {
  const WarningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: AppDouble.paddingOutside),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(AppDouble.borderRadius),
        boxShadow: [
          AppStyles.boxShadowStyle,
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Perhatian",
            style: TextStyle(
              color: AppColors.redColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Halaman ini hanya digunakan jika ingin mengubah status saat terjadi kesalahan. Salah satu contohnya jika status tertera Selesai, Surat Dapat Diunduh, namun salah mengupload scan surat hasil rekomendasi, maka klik tombol Ubah status dan pilih status menjadi upload scan surat rekomendasi kemudian upload kembali hasil scan suratnya.",
            style: TextStyle(
              color: AppColors.redColor,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
