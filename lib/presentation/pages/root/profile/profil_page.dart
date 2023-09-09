import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/domain/entity/auth.dart';
import 'package:flutter_map_simtaru/presentation/controllers/auth_controller.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_profile.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/profile_card.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/controllers/index_screen_provider.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_appbar_fitur.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilPage extends ConsumerWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

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
                                    await ref
                                        .read(authControllerProvider.notifier)
                                        .logout();
                                    authState.whenData((value) {
                                      if (value == const Auth.signedOut()) {
                                        ref
                                            .read(indexScreenProvider.notifier)
                                            .onIndexChange(0);
                                      }
                                    });
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
                              label: "Seluruh Pengajuan",
                              icon: Icons.assignment_rounded,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                color: AppColors.borderColor,
                              ),
                            ),
                            ButtonProfile(
                              label: "Pengajuan Ditolak",
                              icon: Icons.assignment_late_outlined,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                color: AppColors.borderColor,
                              ),
                            ),
                            ButtonProfile(
                              label: "Surat Rekomendasi",
                              icon: Icons.assignment_add,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                color: AppColors.borderColor,
                              ),
                            ),
                            ButtonProfile(
                              label: "Upload Scan Surat",
                              icon: Icons.assignment_turned_in_outlined,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                color: AppColors.borderColor,
                              ),
                            ),
                            ButtonProfile(
                              label: "Penerbitan Surat",
                              icon: Icons.assignment_returned_outlined,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                color: AppColors.borderColor,
                              ),
                            ),
                            ButtonProfile(
                              label: "Penomoran Surat",
                              icon: Icons.assignment_outlined,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                color: AppColors.borderColor,
                              ),
                            ),
                            ButtonProfile(
                              label: "Persetujuan TKPRD",
                              icon: Icons.assignment_ind_outlined,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                color: AppColors.borderColor,
                              ),
                            ),
                            ButtonProfile(
                              label: "Persetujuan PUPR",
                              icon: Icons.assignment_ind_outlined,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                color: AppColors.borderColor,
                              ),
                            ),
                            ButtonProfile(
                              label: "Verifikasi Lapangan",
                              icon: Icons.add_location_alt_outlined,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                color: AppColors.borderColor,
                              ),
                            ),
                            ButtonProfile(
                              label: "Verifikasi Berkas",
                              icon: Icons.file_open_outlined,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                color: AppColors.borderColor,
                              ),
                            ),
                            ButtonProfile(
                              label: "Revisi Berkas",
                              icon: Icons.file_copy_outlined,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                color: AppColors.borderColor,
                              ),
                            ),
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
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
