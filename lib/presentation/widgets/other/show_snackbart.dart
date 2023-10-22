import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';

class AppSnackBar {
  static show(
    BuildContext context,
    String text, [
    Color? color,
    IconData? icon,
  ]) async {
    await Flushbar(
      message: text,
      backgroundColor: color ?? AppColors.blackColor,
      duration: const Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      animationDuration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      isDismissible: true,
      shouldIconPulse: false,
      icon: Icon(
        icon ?? Icons.info_outline_rounded,
        color: AppColors.whiteColor,
      ),
    ).show(context);
  }
}
