import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/custom_appbar_fitur.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.bgColor,
        child: Column(
          children: [
            const CustomAppBarFitur(
              title: "Profil",
              bgColor: AppColors.bgColor,
              labelColor: AppColors.blackColor,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.blackColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "John Doe",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "johndoe@email.com",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Pengaturan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: const Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(width: 10),
                            Text("Edit Profil"),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.lock),
                            SizedBox(width: 10),
                            Text("Ganti Password"),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.logout, color: AppColors.redColor),
                            SizedBox(width: 10),
                            Text(
                              "Keluar",
                              style: TextStyle(
                                color: AppColors.redColor,
                              ),
                            ),
                          ],
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
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: const Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.people),
                            SizedBox(width: 10),
                            Text("Kelola User"),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.engineering),
                            SizedBox(width: 10),
                            Text("Kelola Admin"),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.rebase_edit),
                            SizedBox(width: 10),
                            Text("Ubah Status"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
