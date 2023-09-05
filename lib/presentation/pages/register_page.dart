import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/image.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_common.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_password.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Image.asset(Images.logo),
                    const SizedBox(height: 20),
                    const Text(
                      "Daftar",
                      style: AppStyles.title,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const TextFieldCommon(
                            labelText: "NIK",
                          ),
                          const SizedBox(height: 10),
                          const TextFieldCommon(
                            labelText: "Nama Lengkap",
                          ),
                          const SizedBox(height: 10),
                          const TextFieldCommon(
                            labelText: "Email",
                          ),
                          const SizedBox(height: 10),
                          const TextFieldPassword(),
                          const SizedBox(height: 10),
                          const TextFieldPassword(),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              context.go('/login');
                            },
                            child: const Text("Daftar",
                                style: AppStyles.textButton),
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
                                    context.go('/login');
                                  },
                                  style: AppStyles.textButtonStyle,
                                  child: const Text(
                                    "Masuk",
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
            ],
          ),
        ),
      ),
    );
  }
}
