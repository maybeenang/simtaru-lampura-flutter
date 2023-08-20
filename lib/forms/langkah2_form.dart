import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/textfield_common.dart';

class Langkah2Form extends StatelessWidget {
  const Langkah2Form({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TextFiledCommon(labelText: "No. Identitas"),
        SizedBox(height: 10),
        TextFiledCommon(labelText: "Bertindak atas nama"),
        SizedBox(height: 10),
        TextFiledCommon(labelText: "Penggunaan tanah saat dimohon"),
        SizedBox(height: 10),
        TextFiledCommon(labelText: "Luas tanah seluruhnya m2"),
        SizedBox(height: 10),
        TextFiledCommon(labelText: "Luas tanah yang dimohon m2"),
        SizedBox(height: 10),
        TextFiledCommon(labelText: "Bukti penguasaan tanah"),
      ],
    );
  }
}
