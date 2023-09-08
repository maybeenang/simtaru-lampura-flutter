import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';

class ButtonCallToAction extends StatelessWidget {
  const ButtonCallToAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDouble.paddingOutside),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.actionColor,
          borderRadius: BorderRadius.circular(AppDouble.borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.actionColor.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(50),
          clipBehavior: Clip.antiAlias,
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Future.delayed(
                const Duration(milliseconds: 300),
                () {
                  const PengajuanRoute().go(context);
                },
              );
            },
            child: Ink(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pengajuan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Icon(
                    Icons.arrow_right_alt,
                    size: 40,
                    color: AppColors.whiteColor,
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
