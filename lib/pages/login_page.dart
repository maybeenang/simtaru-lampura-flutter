import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/textfield_common.dart';
import 'package:flutter_map_simtaru/components/textfield_password.dart';
import 'package:flutter_map_simtaru/constants/image.dart';
import 'package:flutter_map_simtaru/styles/styles.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
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
                  const TextFiledCommon(labelText: "NIP"),
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
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.right,
                        )),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/home');
                    },
                    child: const Text("Masuk", style: AppStyles.textButton),
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
                            context.go('/register');
                          },
                          style: AppStyles.textButtonStyle,
                          child: const Text(
                            "Daftar",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
