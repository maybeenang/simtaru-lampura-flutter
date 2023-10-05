import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/presentation/controllers/form/form_state.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_common.dart';

class Langkah2Form extends StatelessWidget {
  const Langkah2Form({super.key, required this.inputController});

  final List inputController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formPengajuanKey2,
      child: Column(
        children: [
          TextFieldCommon(
            labelText: "No. Identitas",
            controller: inputController[5],
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
          ),
          const SizedBox(height: 10),
          TextFieldCommon(
            labelText: "Luas tanah yang dimohon m2",
            controller: inputController[9],
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
