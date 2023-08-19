import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
          color: AppColors.secondaryColor,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat Datang",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Sistem Informasi Tata Ruang Kabupaten Lampung Utara",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
