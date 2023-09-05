import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
      ),
      child: const Text(
        "Verifikasi Lapangan",
        style: TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
