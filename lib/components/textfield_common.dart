import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/styles/styles.dart';

class TextFiledCommon extends StatelessWidget {
  const TextFiledCommon({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: AppStyles.inputDecoration.copyWith(
      labelText: "NIP",
    ));
  }
}
