import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:flutter_map_simtaru/states/providers/index_screen_provider.dart';
import 'package:flutter_map_simtaru/styles/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubHeader extends ConsumerWidget {
  const SubHeader({super.key, required this.labelText});

  final String labelText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            labelText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {
              labelText == "Overview"
                  ? ref.read(indexScreenProvider.notifier).onIndexChange(1)
                  : ref.read(indexScreenProvider.notifier).onIndexChange(3);
            },
            style: AppStyles.textButtonStyle,
            child: const Text(
              "Selngkapnya",
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
