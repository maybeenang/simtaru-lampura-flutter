import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user_utils.dart';
import 'package:flutter_map_simtaru/presentation/controllers/form/form_state.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user/admin_user_controller.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_common.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AdminEditUserPage extends HookConsumerWidget {
  const AdminEditUserPage({super.key, required this.user});

  final UserUtils user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = List.generate(5, (index) => useTextEditingController());

    void submitForm() async {
      FocusScope.of(context).unfocus();
      if (formEditUserKey.currentState!.validate()) {
        context.loaderOverlay.show();
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

        var data = inputController[3].text == "" && inputController[4].text == ""
            ? {
                "no_ktp": int.parse(inputController[0].text),
                "name": inputController[1].text,
                "email": inputController[2].text,
              }
            : {
                "no_ktp": int.parse(inputController[0].text),
                "name": inputController[1].text,
                "email": inputController[2].text,
                "password": inputController[3].text,
              };

        if (inputController[0].text == user.no_ktp.toString()) {
          data.remove("no_ktp");
        }

        if (inputController[2].text == user.email) {
          data.remove("email");
        }

        final result = await ref.read(adminUserControllerProvider.notifier).editUser(data, user.id.toString());

        result.when(
          success: (data) {
            context.loaderOverlay.hide();
            Flushbar(
              message: "Berhasil Edit User",
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
          title: const Text("Edit User"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.network(
                    user.profile_photo_url,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: formEditUserKey,
                  child: Column(
                    children: [
                      TextFieldCommon(
                        labelText: "NIK/No. KTP",
                        isNik: true,
                        controller: inputController[0],
                        initialValue: user.no_ktp.toString(),
                      ),
                      const SizedBox(height: 5),
                      TextFieldCommon(
                        labelText: "Nama Lengkap",
                        controller: inputController[1],
                        initialValue: user.name,
                      ),
                      const SizedBox(height: 5),
                      TextFieldCommon(
                        labelText: "Email",
                        isEmail: true,
                        controller: inputController[2],
                        initialValue: user.email,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                const SizedBox(height: 5),
                const Text(
                  "Hanya diisi jika ingin mengganti password",
                  style: TextStyle(
                    color: AppColors.redColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                TextFieldCommon(
                  labelText: "Password",
                  isPassword: true,
                  controller: inputController[3],
                ),
                const SizedBox(height: 5),
                TextFieldCommon(
                  labelText: "Konfirmasi Password",
                  isPassword: true,
                  controller: inputController[4],
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    submitForm();
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
