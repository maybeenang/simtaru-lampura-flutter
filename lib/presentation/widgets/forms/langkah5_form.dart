import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_uploadfile.dart';

class Langkah5Form extends StatefulWidget {
  const Langkah5Form({super.key});

  @override
  State<Langkah5Form> createState() => _Langkah5FormState();
}

class _Langkah5FormState extends State<Langkah5Form> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TextFieldUploadFile(labelText: "Fotocopy KTP"),
        TextFieldUploadFile(labelText: "Fotocopy Sertifikat/Surat Tanah"),
        TextFieldUploadFile(labelText: "Fotocopy SPPT PBB"),
        TextFieldUploadFile(labelText: "Fotocopy NPWP"),
        TextFieldUploadFile(
            labelText:
                "Surat Persetujuan Tetangga Dilampirkan FC KTP Diketahui Oleh Kades/Lurah & Camat"),
      ],
    );
  }
}
