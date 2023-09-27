import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_profile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminMenuProfileCard extends ConsumerWidget {
  const AdminMenuProfileCard({super.key});

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
                  label: "Seluruh Pengajuan",
                  icon: Icons.assignment_rounded,
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 300),
                      () => const AdminSeluruhPengajuanRoute().go(context),
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: AppColors.borderColor,
                  ),
                ),
                const ButtonProfile(
                  label: "Pengajuan Ditolak",
                  icon: Icons.assignment_late_outlined,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: AppColors.borderColor,
                  ),
                ),
                const ButtonProfile(
                  label: "Surat Rekomendasi",
                  icon: Icons.assignment_add,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: AppColors.borderColor,
                  ),
                ),
                const ButtonProfile(
                  label: "Upload Scan Surat",
                  icon: Icons.assignment_turned_in_outlined,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: AppColors.borderColor,
                  ),
                ),
                const ButtonProfile(
                  label: "Verifikasi Lapangan",
                  icon: Icons.add_location_alt_outlined,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: AppColors.borderColor,
                  ),
                ),
                const ButtonProfile(
                  label: "Verifikasi Berkas",
                  icon: Icons.file_open_outlined,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: AppColors.borderColor,
                  ),
                ),
                const ButtonProfile(
                  label: "Revisi Berkas",
                  icon: Icons.file_copy_outlined,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: AppColors.borderColor,
                  ),
                ),
                const ButtonProfile(
                  label: "Kelola User",
                  icon: Icons.group,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: AppColors.borderColor,
                  ),
                ),
                const ButtonProfile(
                  label: "Kelola Berita",
                  icon: Icons.newspaper,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
