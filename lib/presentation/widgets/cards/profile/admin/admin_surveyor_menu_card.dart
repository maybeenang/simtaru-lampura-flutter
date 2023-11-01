import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_profile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminSurveyorMenuCard extends ConsumerWidget {
  const AdminSurveyorMenuCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppDouble.paddingOutside,
      ),
      child: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              "Admin",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                AppStyles.boxShadowStyle,
              ],
            ),
            child: Column(
              children: [
                ButtonProfile(
                  label: "Upload Scan Surat",
                  icon: Icons.assignment_turned_in_outlined,
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 300),
                      () => const AdminUploadScanSuratRoute().push(context),
                    );
                  },
                  isNotif: true,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: AppColors.borderColor,
                  ),
                ),
                ButtonProfile(
                  label: "Surat Rekomendasi",
                  icon: Icons.assignment_add,
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 300),
                      () => const AdminSuratRekomendasiRoute().push(context),
                    );
                  },
                  isNotif: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
