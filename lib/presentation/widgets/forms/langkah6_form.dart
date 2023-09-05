import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_uploadfile.dart';

class Langkah6Form extends StatefulWidget {
  const Langkah6Form({super.key});

  @override
  State<Langkah6Form> createState() => _Langkah6FormState();
}

class _Langkah6FormState extends State<Langkah6Form> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TextFieldUploadFile(labelText: "Gambar Rencana Bangunan"),
        TextFieldUploadFile(labelText: "Fotocopy Akte Pendirian Perusahaan"),
        TextFieldUploadFile(labelText: "Set Lokasi Bangunan"),
        TextFieldUploadFile(
            labelText:
                "Surat Pernyataan Dari Pemohon (Pemilik) Jika Terjadi Force Majeur"),
        TextFieldUploadFile(labelText: "Uraian Rencana Proyek (Proposal)"),
      ],
    );
  }
}
