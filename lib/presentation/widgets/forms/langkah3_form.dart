import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/presentation/controllers/form/form_state.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_common.dart';

class Langkah3Form extends StatelessWidget {
  const Langkah3Form({super.key, required this.inputController});

  final List inputController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formPengajuanKey3,
      child: Column(
        children: [
          TextFieldCommon(labelText: "Letak tanah", controller: inputController[11]),
          const SizedBox(height: 10),
          TextFieldCommon(labelText: "Rencana penggunaan tanah", controller: inputController[12]),
          const SizedBox(height: 10),
          TextFieldCommon(labelText: "Batas sebelah utara", controller: inputController[13]),
          const SizedBox(height: 10),
          TextFieldCommon(labelText: "Batas sebelah timur", controller: inputController[14]),
          const SizedBox(height: 10),
          TextFieldCommon(labelText: "Batas sebelah selatan", controller: inputController[15]),
          const SizedBox(height: 10),
          TextFieldCommon(labelText: "Batas sebelah barat", controller: inputController[16]),
        ],
      ),
    );
  }
}
