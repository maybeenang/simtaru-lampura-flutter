import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_profile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminVerifLapanganMenuCard extends ConsumerWidget {
  const AdminVerifLapanganMenuCard({super.key});

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
                  label: "Verifikasi Lapangan",
                  icon: Icons.add_location_alt_outlined,
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 300),
                      () => const AdminVerifikasiLapanganRoute().push(context),
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
