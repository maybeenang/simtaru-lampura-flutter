import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/controllers/form/form_state.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user/admin_user_controller.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_common.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AdminTambahUserPage extends HookConsumerWidget {
  const AdminTambahUserPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = List.generate(5, (index) => useTextEditingController());

    void handleSubmit() async {
      FocusScope.of(context).unfocus();
      if (formTambahUserKey.currentState!.validate()) {
        if (inputController[3].text != inputController[4].text) {
          Flushbar(
            message: "Password tidak sama",
            backgroundColor: AppColors.redColor,
            duration: const Duration(seconds: 3),
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.FLOATING,
            animationDuration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(8),
            isDismissible: true,
            shouldIconPulse: false,
            icon: const Icon(
              Icons.close,
              color: AppColors.whiteColor,
            ),
          ).show(context);
          return;
        }

        context.loaderOverlay.show();

        final data = {
          "no_ktp": int.parse(inputController[0].text),
          "name": inputController[1].text,
          "email": inputController[2].text,
          "password": inputController[3].text,
        };

        final result = await ref.read(adminUserControllerProvider.notifier).createUser(data);

        result.when(
          success: (data) {
            context.loaderOverlay.hide();
            Flushbar(
              message: "Berhasil Tambah User",
              backgroundColor: AppColors.greenColor,
              duration: const Duration(seconds: 1),
              flushbarPosition: FlushbarPosition.TOP,
              flushbarStyle: FlushbarStyle.FLOATING,
              animationDuration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
              isDismissible: true,
              shouldIconPulse: false,
              icon: const Icon(
                Icons.check,
                color: AppColors.whiteColor,
              ),
            ).show(context).then((value) => context.pop());
            ref.invalidate(adminUserControllerProvider);
          },
          error: (error) {
            context.loaderOverlay.hide();

            Flushbar(
              message: error.toString(),
              backgroundColor: AppColors.redColor,
              duration: const Duration(seconds: 3),
              flushbarPosition: FlushbarPosition.TOP,
              flushbarStyle: FlushbarStyle.FLOATING,
              animationDuration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
              isDismissible: true,
              shouldIconPulse: false,
              icon: const Icon(
                Icons.close,
                color: AppColors.whiteColor,
              ),
            ).show(context);
          },
        );
      }
    }

    return CustomSafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tambah User"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Tambah User",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: formTambahUserKey,
                  child: Column(
                    children: [
                      TextFieldCommon(
                        labelText: "NIK/No. KTP",
                        isNik: true,
                        controller: inputController[0],
                      ),
                      const SizedBox(height: 5),
                      TextFieldCommon(
                        labelText: "Nama Lengkap",
                        controller: inputController[1],
                      ),
                      const SizedBox(height: 5),
                      TextFieldCommon(
                        labelText: "Email",
                        isEmail: true,
                        controller: inputController[2],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Password",
                        isPassword: true,
                        controller: inputController[3],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Konfirmasi Password",
                        isPassword: true,
                        controller: inputController[4],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    handleSubmit();
                  },
                  child: const Text(
                    "Simpan",
                    style: TextStyle(color: AppColors.whiteColor, fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
