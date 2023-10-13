import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonIcon extends ConsumerWidget {
  const ButtonIcon({super.key, this.bgColor, this.icon, this.onTap});

  final Color? bgColor;
  final IconData? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Icon(
          icon ?? Icons.add,
          size: 20,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
