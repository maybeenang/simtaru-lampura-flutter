import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/image.dart';
import 'package:flutter_map_simtaru/presentation/controllers/auth_controller.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_common.dart';
import 'package:flutter_map_simtaru/presentation/widgets/other/show_snackbart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

final registerFormKey = GlobalKey<FormState>();

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nikController = useTextEditingController();
    final namaController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final konfirmasiPasswordController = useTextEditingController();

    return WillPopScope(
      onWillPop: () {
        context.pop();
        return Future.value(false);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image(
                  image: const AssetImage(Images.bgPeta),
                  height: 200,
                  fit: BoxFit.cover,
                  color: AppColors.primaryColor.withOpacity(0.5),
                ),
              ),
              Center(
                heightFactor: 1.5,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Daftar",
                      style: AppStyles.title,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: registerFormKey,
                        onChanged: () {
                          registerFormKey.currentState!.validate();
                        },
                        child: Column(
                          children: [
                            TextFieldCommon(
                              labelText: "NIK",
                              controller: nikController,
                              isNik: true,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 10),
                            TextFieldCommon(
                              labelText: "Nama Lengkap",
                              controller: namaController,
                            ),
                            const SizedBox(height: 10),
                            TextFieldCommon(
                              labelText: "Email",
                              controller: emailController,
                              isEmail: true,
                            ),
                            const SizedBox(height: 10),
                            TextFieldCommon(
                              labelText: "Password",
                              isPassword: true,
                              controller: passwordController,
                            ),
                            const SizedBox(height: 10),
                            TextFieldCommon(
                              labelText: "Konfirmasi Password",
                              isPassword: true,
                              controller: konfirmasiPasswordController,
                              isLast: true,
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () async {
                                FocusScope.of(context).unfocus();

                                if (registerFormKey.currentState!.validate()) {
                                  if (passwordController.text == konfirmasiPasswordController.text) {
                                    context.loaderOverlay.show();
                                    await ref.read(authControllerProvider.notifier).register(
                                          nikController.text,
                                          namaController.text,
                                          emailController.text,
                                          passwordController.text,
                                        );
                                    if (context.mounted) {
                                      context.loaderOverlay.hide();
                                    }
                                  } else {
                                    AppSnackBar.show(
                                      context,
                                      "Password tidak sama",
                                      AppColors.redColor,
                                      Icons.error_outline_rounded,
                                    );
                                  }
                                }
                              },
                              child: const Text(
                                "Daftar",
                                style: AppStyles.textButton,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Sudah punya akun? ",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  style: AppStyles.textButtonStyle,
                                  child: const Text(
                                    "Masuk",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
