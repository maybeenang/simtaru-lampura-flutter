import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
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
        const Text(
          "Ganti Foto",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Column(
            children: [
              TextFormField(
                initialValue: "1234567890123456",
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
                initialValue: "John Doe",
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
                initialValue: "johndoe@email.com",
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
            style: TextStyle(
                color: AppColors.whiteColor, fontWeight: FontWeight.w700),
          ),
        )
      ],
    );
  }
}
