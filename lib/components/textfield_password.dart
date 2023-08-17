import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/styles/styles.dart';

class TextFieldPassword extends StatelessWidget {
  const TextFieldPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: AppStyles.inputDecoration.copyWith(
        labelText: "Password",
      ),
    );
  }
}
