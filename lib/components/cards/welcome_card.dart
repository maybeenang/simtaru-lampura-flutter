import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:flutter_map_simtaru/constants/double.dart';
import 'package:flutter_map_simtaru/styles/styles.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      clipBehavior: Clip.antiAlias,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(AppDouble.borderRadius),
        boxShadow: [AppStyles.boxShadowStyle],
      ),
      child: Stack(
        children: [
          Image(
            image: AssetImage(image),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
            ),
          ),
        ],
      ),
      // const Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       "Selamat Datang",
      //       style: TextStyle(
      //         color: AppColors.whiteColor,
      //         fontSize: 20,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //     SizedBox(height: 10),
      //     Text(
      //       "Sistem Informasi Tata  Kabupaten Lampung Utara",
      //       style: TextStyle(
      //         color: AppColors.whiteColor,
      //         fontSize: 14,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
