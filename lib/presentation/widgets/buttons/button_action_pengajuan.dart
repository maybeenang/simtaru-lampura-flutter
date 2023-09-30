import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonActionPengajuan extends ConsumerWidget {
  const ButtonActionPengajuan({super.key, this.label, this.icon, this.color});

  final String? label;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color ?? AppColors.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                const SizedBox(width: 20),
                Icon(icon ?? Icons.abc, color: AppColors.whiteColor),
                const SizedBox(width: 20),
                Text(label ?? "Button", style: const TextStyle(fontSize: 16, color: AppColors.whiteColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
