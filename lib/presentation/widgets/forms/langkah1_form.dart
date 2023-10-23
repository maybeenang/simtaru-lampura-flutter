import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/presentation/controllers/form/form_state.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user_controller.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Langkah1Form extends HookConsumerWidget {
  const Langkah1Form({super.key, required this.inputController});

  final List inputController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userControllerProvider);
    return Form(
      key: formPengajuanKey1,
      child: Column(
        children: [
          TextFieldCommon(
            labelText: "Nama Lengkap",
            controller: inputController[0],
            initialValue: userState.maybeWhen(
              data: (data) {
                if (data is UserSuccess) {
                  return data.model.name;
                } else {
                  return null;
                }
              },
              orElse: () => null,
            ),
          ),
          const SizedBox(height: 10),
          TextFieldCommon(
            labelText: "Tempat, Tanggal Lahir",
            controller: inputController[1],
          ),
          const SizedBox(height: 10),
          TextFieldCommon(
            labelText: "Alamat",
            controller: inputController[2],
          ),
          const SizedBox(height: 10),
          TextFieldCommon(
            labelText: "No. HP",
            keyboardType: TextInputType.number,
            controller: inputController[3],
            isNoHp: true,
          ),
          const SizedBox(height: 10),
          TextFieldCommon(
            labelText: "Pekerjaan",
            controller: inputController[4],
          ),
        ],
      ),
    );
  }
}
