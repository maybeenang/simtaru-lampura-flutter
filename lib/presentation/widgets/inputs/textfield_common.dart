import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/root_page.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TextFieldCommon extends ConsumerWidget {
  const TextFieldCommon({super.key, required this.labelText, this.focusNode});

  final String labelText;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      focusNode: focusNode,
      onTap: () {
        focusNode?.requestFocus();
        ref.read(hideNavbarProvider.notifier).state = true;
      },
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
        labelStyle: const TextStyle(
          color: AppColors.greyColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
