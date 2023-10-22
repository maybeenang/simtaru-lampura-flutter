import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TextFieldCommon extends HookConsumerWidget {
  const TextFieldCommon({
    super.key,
    required this.labelText,
    this.focusNode,
    this.controller,
    this.keyboardType,
    this.isPassword,
    this.isLast,
    this.isEmail,
    this.isNik,
    this.initialValue,
    this.readOnly,
    this.onTap,
  });

  final String labelText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final bool? isLast;
  final bool? isEmail;
  final bool? isNik;
  final bool? readOnly;
  final String? initialValue;
  final Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hidePassword = useState<bool>(isPassword ?? false);

    if (initialValue != null && controller!.text.isEmpty) {
      controller!.text = initialValue!;
    }

    return TextFormField(
      onTap: onTap,
      keyboardType: keyboardType ?? TextInputType.text,
      controller: controller,
      obscureText: hidePassword.value,
      textInputAction: isLast == true ? TextInputAction.done : TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText tidak boleh kosong';
        }
        if (isEmail == true) {
          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
            return 'Email tidak valid';
          }
        }
        if (isPassword == true) {
          if (value.length < 8) {
            return 'Password tidak boleh kurang dari 8 digit';
          }
        }
        if (isNik == true) {
          if (value.length < 16) {
            return 'NIK tidak boleh kurang dari 16 digit';
          }
        }
        return null;
      },
      readOnly: readOnly ?? false,
      decoration: AppStyles.inputDecoration.copyWith(
        suffixIcon: isPassword == true
            ? IconButton(
                onPressed: () {
                  hidePassword.value = !hidePassword.value;
                },
                icon: Icon(
                  hidePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: AppColors.greyColor,
                  size: 20,
                ),
              )
            : null,
        labelText: labelText,
      ),
    );
  }
}
