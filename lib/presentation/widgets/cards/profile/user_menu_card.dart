import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/controllers/auth_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/index_screen_provider.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_profile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UserMenuProfileCard extends ConsumerWidget {
  const UserMenuProfileCard({super.key});

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
              "Pengaturan",
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
                  label: "Edit Profil",
                  icon: Icons.edit,
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 300),
                      () {
                        const EditProfileRoute().go(context);
                      },
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
                  label: "Ganti Password",
                  icon: Icons.lock,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: AppColors.borderColor,
                  ),
                ),
                ButtonProfile(
                  label: "Logout",
                  icon: Icons.logout,
                  color: AppColors.redColor,
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 500),
                      () async {
                        context.loaderOverlay.show();
                        await ref.read(authControllerProvider.notifier).logout();
                        ref.read(indexScreenProvider.notifier).onIndexChange(0);
                        context.loaderOverlay.hide();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
