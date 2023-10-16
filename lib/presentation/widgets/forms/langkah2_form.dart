import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/presentation/controllers/form/form_state.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user_controller.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Langkah2Form extends HookConsumerWidget {
  const Langkah2Form({super.key, required this.inputController});

  final List inputController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userControllerProvider);

    return Form(
      key: formPengajuanKey2,
      child: Column(
        children: [
          TextFieldCommon(
            labelText: "No. Identitas",
            controller: inputController[5],
            isNik: true,
            keyboardType: TextInputType.number,
            initialValue: userState.maybeWhen(
              data: (data) {
                if (data is UserSuccess) {
                  return data.model.no_ktp.toString();
                } else {
                  return null;
                }
              },
              orElse: () => null,
            ),
          ),
          const SizedBox(height: 10),
          TextFieldCommon(
            labelText: "Bertindak atas nama",
            controller: inputController[6],
          ),
          const SizedBox(height: 10),
          TextFieldCommon(
            labelText: "Penggunaan tanah saat dimohon",
            controller: inputController[7],
          ),
          const SizedBox(height: 10),
          TextFieldCommon(
            labelText: "Luas tanah seluruhnya m2",
            controller: inputController[8],
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          TextFieldCommon(
            labelText: "Luas tanah yang dimohon m2",
            controller: inputController[9],
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          TextFieldCommon(
            labelText: "Bukti penguasaan tanah",
            controller: inputController[10],
          ),
        ],
      ),
    );
  }
}
