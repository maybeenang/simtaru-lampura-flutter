import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user_utils.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_common.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminEditUserPage extends HookConsumerWidget {
  const AdminEditUserPage({super.key, required this.user});

  final UserUtils user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = List.generate(5, (index) => useTextEditingController());

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
                Column(
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
                const TextFieldCommon(
                  labelText: "Password",
                  isPassword: true,
                ),
                const SizedBox(height: 5),
                const TextFieldCommon(
                  labelText: "Konfirmasi Password",
                  isPassword: true,
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
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
