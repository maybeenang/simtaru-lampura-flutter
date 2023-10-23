import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditPasswordForm extends HookConsumerWidget {
  const EditPasswordForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
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
                decoration: const InputDecoration(
                  labelText: "Password Saat ini",
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
                decoration: const InputDecoration(
                  labelText: "Password Baru",
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
                decoration: const InputDecoration(
                  labelText: "Konfirmasi Passsword Baru",
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
