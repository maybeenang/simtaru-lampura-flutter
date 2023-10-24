import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:shimmer/shimmer.dart';

class ItemArtikelLoading extends StatelessWidget {
  const ItemArtikelLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(AppDouble.borderRadius),
          boxShadow: [
            AppStyles.boxShadowStyle,
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
