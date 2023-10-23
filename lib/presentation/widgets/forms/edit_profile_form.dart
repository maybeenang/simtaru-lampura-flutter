import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user_controller.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditProfileForm extends HookConsumerWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userControllerProvider);
    final user = userState.maybeWhen(
      orElse: () => null,
      data: (data) {
        if (data is UserSuccess) {
          return data.model;
        }
      },
    );

    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 10),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              AppStyles.boxShadowStyle,
            ],
          ),
          child: Column(
            children: [
              TextFormField(
                readOnly: true,
                initialValue: user?.no_ktp.toString() ?? "",
                decoration: const InputDecoration(
                  labelText: "NIK/No. KTP",
                  labelStyle: TextStyle(
                    color: AppColors.greyColor,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 10,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.borderColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                initialValue: user?.name ?? "",
                decoration: const InputDecoration(
                  labelText: "Nama Lengkap",
                  labelStyle: TextStyle(
                    color: AppColors.greyColor,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 10,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.borderColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                initialValue: user?.email ?? "",
                decoration: const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: AppColors.greyColor,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 10,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.borderColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15)
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: const Text(
            "Simpan",
            style: TextStyle(color: AppColors.whiteColor, fontWeight: FontWeight.w700),
          ),
        )
      ],
    );
  }
}
