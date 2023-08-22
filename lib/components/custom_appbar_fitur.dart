import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class CustomAppBarFitur extends StatelessWidget {
  const CustomAppBarFitur({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
