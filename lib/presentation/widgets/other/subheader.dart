import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubHeader extends ConsumerWidget {
  const SubHeader({super.key, required this.labelText, this.showAction = false, this.onTap});

  final String labelText;
  final bool showAction;
  final Function? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            labelText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          !showAction
              ? const SizedBox()
              : TextButton(
                  onPressed: onTap as void Function()?,
                  style: AppStyles.textButtonStyle,
                  child: const Text(
                    "Selengkapnya",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
