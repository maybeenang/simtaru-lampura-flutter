import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Text(
        "Upload Scan Surat Hasil Rekomendasi",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
