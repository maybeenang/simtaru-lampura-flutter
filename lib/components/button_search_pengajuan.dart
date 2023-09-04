import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:flutter_map_simtaru/styles/styles.dart';
import 'package:go_router/go_router.dart';

class ButtonSearchPengajuan extends StatelessWidget {
  const ButtonSearchPengajuan({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            AppStyles.boxShadowStyle,
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context.push('/search_pengajuan');
            },
            child: Ink(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.search,
                    color: AppColors.greyColor,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: const Text(
                      "Cari pengajuan",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
