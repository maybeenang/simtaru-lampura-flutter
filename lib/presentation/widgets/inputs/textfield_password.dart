import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';

class TextFieldPassword extends StatelessWidget {
  const TextFieldPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong';
        }
        return null;
      },
      obscureText: true,
      decoration: AppStyles.inputDecoration.copyWith(
        filled: true,
        fillColor: AppColors.whiteColor,
        labelText: "Password",
        labelStyle: const TextStyle(
          color: AppColors.greyColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
