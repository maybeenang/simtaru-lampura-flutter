// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/image.dart';
import 'package:flutter_map_simtaru/domain/entity/auth/auth.dart';
import 'package:flutter_map_simtaru/presentation/controllers/auth_controller.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_map_simtaru/presentation/widgets/other/show_snackbart.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final loginFormKey = GlobalKey<FormState>();

    final nikController = useTextEditingController();
    final passwordController = useTextEditingController();

    // ignore: prefer_typing_uninitialized_variables
    var currentBackPressTime;

    // ignore: no_leading_underscores_for_local_identifiers
    Future<bool> _onWillPop(BuildContext context) async {
      DateTime now = DateTime.now();

      if (currentBackPressTime == null || now.difference(currentBackPressTime!!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        AppSnackBar.show(
          context,
          "Tekan sekali lagi untuk keluar",
          AppColors.redColor,
        );
        return Future.value(false);
      }

      return Future.value(true);
    }

    ref.listen(
      authControllerProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            if (data is Error) {
              AppSnackBar.show(context, data.message, AppColors.redColor, Icons.dangerous);
            }
            if (data is SignedUp) {
              AppSnackBar.show(context, "Berhasil Mendaftar", AppColors.greenColor, Icons.check);
            }
          },
          error: (error, stackTrace) {
            AppSnackBar.show(context, error.toString(), AppColors.redColor, Icons.dangerous);
          },
        );
      },
    );

    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Image(
                  image: const AssetImage(Images.bgPeta),
                  height: 200,
                  fit: BoxFit.cover,
                  color: AppColors.primaryColor.withOpacity(0.5),
                ),
              ),
              Center(
                heightFactor: 1.5,
                child: Form(
                  onChanged: () {
                    loginFormKey.currentState!.validate();
                  },
                  key: loginFormKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Images.logo),
                      const SizedBox(height: 50),
                      const Text(
                        "Masuk",
                        style: AppStyles.title,
                      ),
                      const Text(
                        "Masukan NIP dan Password untuk melanjutkan",
                        style: AppStyles.subtitle,
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            TextFieldCommon(
                              labelText: "NIK",
                              controller: nikController,
                              keyboardType: TextInputType.number,
                              isNik: true,
                            ),
                            const SizedBox(height: 10),
                            TextFieldCommon(
                              labelText: "Password",
                              controller: passwordController,
                              isPassword: true,
                              isLast: true,
                            ),
                            const SizedBox(height: 10),
                            Container(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {
                                    const ForgetPasswordRoute().push(context);
                                  },
                                  style: AppStyles.textButtonStyle,
                                  child: const Text(
                                    "Lupa Password?",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.right,
                                  )),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                if (loginFormKey.currentState!.validate() && !authState.isLoading) {
                                  final nik = nikController.text.toString();
                                  final password = passwordController.text.toString();
                                  context.loaderOverlay.show();

                                  await ref.read(authControllerProvider.notifier).login(nik, password);
                                  context.loaderOverlay.hide();
                                }
                              },
                              child: authState.maybeWhen(
                                loading: () => const Text(
                                  "Loading",
                                  style: AppStyles.textButton,
                                ),
                                orElse: () => const Text(
                                  "Masuk",
                                  style: AppStyles.textButton,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Belum punya akun? ",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    const RegisterRoute().push(context);
                                  },
                                  style: AppStyles.textButtonStyle,
                                  child: const Text(
                                    "Daftar",
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
