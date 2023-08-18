import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:flutter_map_simtaru/styles/styles.dart';

class TextFiledCommon extends StatelessWidget {
  const TextFiledCommon({super.key, required this.labelText});

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: AppStyles.inputDecoration.copyWith(
      filled: true,
      fillColor: AppColors.whiteColor,
      labelText: labelText,
    ));
  }
}
