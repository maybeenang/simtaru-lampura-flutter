// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/image.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_common.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_password.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginFormKey = GlobalKey<FormState>();

  // ignore: prefer_typing_uninitialized_variables
  var currentBackPressTime;

  Future<bool> _onWillPop(BuildContext context) async {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("Tekan sekali lagi untuk keluar");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tekan sekali lagi untuk keluar"),
        ),
      );
      return Future.value(false);
    }

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
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
              child: Form(
                key: loginFormKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        child: SizedBox(
                      height: 100,
                    )),
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
                          const TextFieldCommon(labelText: "NIK"),
                          const SizedBox(height: 10),
                          const TextFieldPassword(),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
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
                            onPressed: () {
                              if (loginFormKey.currentState!.validate()) {
                                context.go('/');
                              }
                            },
                            child: const Text("Masuk",
                                style: AppStyles.textButton),
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
                                  context.push('/register');
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
    );
  }
}
