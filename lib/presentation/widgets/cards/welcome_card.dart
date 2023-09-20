import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        boxShadow: [AppStyles.boxShadowStyle],
      ),
      child: Image(
        image: AssetImage(image),
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
