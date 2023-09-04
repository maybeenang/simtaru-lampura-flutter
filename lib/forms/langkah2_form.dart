import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/textfield_common.dart';

class Langkah2Form extends StatelessWidget {
  const Langkah2Form({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TextFieldCommon(labelText: "No. Identitas"),
        SizedBox(height: 10),
        TextFieldCommon(labelText: "Bertindak atas nama"),
        SizedBox(height: 10),
        TextFieldCommon(labelText: "Penggunaan tanah saat dimohon"),
        SizedBox(height: 10),
        TextFieldCommon(labelText: "Luas tanah seluruhnya m2"),
        SizedBox(height: 10),
        TextFieldCommon(labelText: "Luas tanah yang dimohon m2"),
        SizedBox(height: 10),
        TextFieldCommon(labelText: "Bukti penguasaan tanah"),
      ],
    );
  }
}
