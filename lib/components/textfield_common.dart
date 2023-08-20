import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:flutter_map_simtaru/styles/styles.dart';

class TextFiledCommon extends StatelessWidget {
  const TextFiledCommon({super.key, required this.labelText});

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText tidak boleh kosong';
        }
        return null;
      },
      decoration: AppStyles.inputDecoration.copyWith(
        filled: true,
        fillColor: AppColors.whiteColor,
        labelText: labelText,
      ),
    );
  }
}
