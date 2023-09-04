import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/textfield_common.dart';

class Langkah3Form extends StatelessWidget {
  const Langkah3Form({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TextFieldCommon(labelText: "Letak tanah"),
        SizedBox(height: 10),
        TextFieldCommon(labelText: "Rencana penggunaan tanah"),
        SizedBox(height: 10),
        TextFieldCommon(labelText: "Batas sebelah utara"),
        SizedBox(height: 10),
        TextFieldCommon(labelText: "Batas sebelah timur"),
        SizedBox(height: 10),
        TextFieldCommon(labelText: "Batas sebelah selatan"),
        SizedBox(height: 10),
        TextFieldCommon(labelText: "Batas sebelah barat"),
      ],
    );
  }
}
