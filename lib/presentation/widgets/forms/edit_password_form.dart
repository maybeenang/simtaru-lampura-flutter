import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/presentation/controllers/form/form_state.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user/admin_user_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user_controller.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_common.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EditPasswordForm extends HookConsumerWidget {
  const EditPasswordForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userControllerProvider);
    final inputController = List.generate(3, (index) => useTextEditingController());
    final user = userState.maybeWhen(
      orElse: () => null,
      data: (data) {
        if (data is UserSuccess) {
          return data.model;
        }
      },
    );

    void submitForm() async {
      FocusScope.of(context).unfocus();
      if (formEditPasswordKey.currentState!.validate()) {
        if (inputController[1].text != inputController[2].text) {
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
          "name": user!.name,
          "password": inputController[1].text,
        };

        final result = await ref.read(adminUserControllerProvider.notifier).editUser(data, user.id.toString());

        result.when(
          success: (data) {
            context.loaderOverlay.hide();
            Flushbar(
              message: "Berhasil Edit Password",
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
            ref.invalidate(userControllerProvider);
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

    return Column(
      children: [
        const SizedBox(height: 20),
        Form(
          key: formEditPasswordKey,
          child: Column(
            children: [
              TextFieldCommon(
                labelText: "Password saat ini",
                isPassword: true,
                controller: inputController[0],
              ),
              const SizedBox(height: 5),
              TextFieldCommon(
                labelText: "Password baru",
                isPassword: true,
                controller: inputController[1],
              ),
              const SizedBox(height: 5),
              TextFieldCommon(
                labelText: "Konfirmasi Password baru",
                isPassword: true,
                controller: inputController[2],
              ),
              const SizedBox(height: 15)
            ],
          ),
        ),
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
    );
  }
}
