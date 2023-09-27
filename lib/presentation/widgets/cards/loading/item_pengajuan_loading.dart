import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:shimmer/shimmer.dart';

class ItemPengajuanLoading extends StatelessWidget {
  const ItemPengajuanLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppDouble.borderRadius),
        boxShadow: [
          AppStyles.boxShadowStyle,
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              width: 125,
              height: 30,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(10)),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(
                15,
                5,
                10,
                15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 15,
                    decoration: const BoxDecoration(
                      color: AppColors.greyColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 200,
                    height: 15,
                    decoration: const BoxDecoration(
                      color: AppColors.greyColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: 100,
                    height: 15,
                    decoration: const BoxDecoration(
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
