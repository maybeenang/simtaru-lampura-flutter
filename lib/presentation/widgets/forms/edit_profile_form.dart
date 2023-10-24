import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/presentation/controllers/form/form_state.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user/admin_user_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user_controller.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_common.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EditProfileForm extends HookConsumerWidget {
  const EditProfileForm({super.key});

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
      if (formEditProfileKey.currentState!.validate()) {
        context.loaderOverlay.show();

        final data = {
          "no_ktp": int.parse(inputController[0].text),
          "name": inputController[1].text,
          "email": inputController[2].text,
        };

        if (inputController[0].text == user!.no_ktp.toString()) {
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
              message: "Berhasil Edit Profil",
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
        Container(
          clipBehavior: Clip.antiAlias,
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.network(
            user!.profile_photo_url,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
        Form(
          key: formEditProfileKey,
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
                readOnly: true,
              ),
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
