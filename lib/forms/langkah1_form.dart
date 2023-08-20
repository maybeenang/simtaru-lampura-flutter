import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/textfield_common.dart';

class Langkah1Form extends StatelessWidget {
  const Langkah1Form({super.key});

  @override
  Widget build(BuildContext context) {
    return const Form(
      child: Column(
        children: [
          TextFiledCommon(labelText: "Nama Lengkap"),
          SizedBox(height: 10),
          TextFiledCommon(labelText: "Tempat, Tanggal Lahir"),
          SizedBox(height: 10),
          TextFiledCommon(labelText: "Alamat"),
          SizedBox(height: 10),
          TextFiledCommon(labelText: "No. HP"),
          SizedBox(height: 10),
          TextFiledCommon(labelText: "Pekerjaan"),
        ],
      ),
    );
  }
}
