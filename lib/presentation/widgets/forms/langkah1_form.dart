import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/presentation/controllers/form/form_state.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_common.dart';

class Langkah1Form extends StatelessWidget {
  const Langkah1Form({super.key, required this.inputController});

  final List inputController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formPengajuanKey1,
      child: Column(
        children: [
          TextFieldCommon(
            labelText: "Nama Lengkap",
            controller: inputController[0],
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
            controller: inputController[3],
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
