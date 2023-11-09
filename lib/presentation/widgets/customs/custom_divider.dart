import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, required String text});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Divider(
        color: AppColors.greyColor,
      ),
    );
  }
}
