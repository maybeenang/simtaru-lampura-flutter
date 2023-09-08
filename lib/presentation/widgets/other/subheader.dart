import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/root_page.dart';
import 'package:flutter_map_simtaru/presentation/controllers/index_screen_provider.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubHeader extends ConsumerWidget {
  const SubHeader({super.key, required this.labelText});

  final String labelText;

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
          TextButton(
            onPressed: () {
              if (labelText == "Overview") {
                ref.read(indexScreenProvider.notifier).onIndexChange(1);
                ref.read(controllerNavbarProvider).index = 1;
              } else if (labelText == "Berita") {
                ref.read(indexScreenProvider.notifier).onIndexChange(3);
                ref.read(controllerNavbarProvider).index = 3;
              }
            },
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
