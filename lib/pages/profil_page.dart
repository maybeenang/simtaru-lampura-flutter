import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/button_profile.dart';
import 'package:flutter_map_simtaru/components/cards/profile_card.dart';
import 'package:flutter_map_simtaru/components/custom_appbar_fitur.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:flutter_map_simtaru/constants/double.dart';
import 'package:flutter_map_simtaru/states/providers/index_screen_provider.dart';
import 'package:flutter_map_simtaru/styles/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfilPage extends ConsumerWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.bgColor,
        child: Column(
          children: [
            const CustomAppBarFitur(
              title: "Profil",
              bgColor: AppColors.primaryColor,
              labelColor: AppColors.whiteColor,
            ),
            Stack(
              children: [
                Container(
                  color: AppColors.primaryColor,
                  child: const SizedBox(
                    width: double.infinity,
                    height: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppDouble.paddingOutside,
                  ),
                  child: Column(
                    children: [
                      const ProfileCard(),
                      const SizedBox(height: 20),
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
                                    context.push('/edit_profile');
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
                                  () {
                                    context.go('/login');
                                    ref
                                        .read(indexScreenProvider.notifier)
                                        .onIndexChange(0);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
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
                        child: const Column(
                          children: [
                            ButtonProfile(
                              label: "Kelola User",
                              icon: Icons.group,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                color: AppColors.borderColor,
                              ),
                            ),
                            ButtonProfile(
                              label: "Kelola Pengajuan",
                              icon: Icons.list_alt,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                color: AppColors.borderColor,
                              ),
                            ),
                            ButtonProfile(
                              label: "Kelola Berita",
                              icon: Icons.newspaper,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
