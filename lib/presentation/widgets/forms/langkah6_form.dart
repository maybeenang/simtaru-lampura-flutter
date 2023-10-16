import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_uploadfile.dart';

class Langkah6Form extends StatefulWidget {
  const Langkah6Form({super.key});

  @override
  State<Langkah6Form> createState() => _Langkah6FormState();
}

class _Langkah6FormState extends State<Langkah6Form> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(3),
          ),
          child: const Text(
            "Upload file dibawah ini dengan format pdf, docx, docx, doc, png, jpeg atau jpg, Sedangkan untuk Gambar Rencana Pembangunan wajib file foto dengan format png, jpeg atau jpg",
            style: TextStyle(
              color: AppColors.primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const TextFieldUploadFile(labelText: "Gambar Rencana Bangunan", index: 5),
        const TextFieldUploadFile(labelText: "Fotocopy Akte Pendirian Perusahaan", index: 6),
        const TextFieldUploadFile(labelText: "Set Lokasi Bangunan", index: 7),
        const TextFieldUploadFile(
            labelText: "Surat Pernyataan Dari Pemohon (Pemilik) Jika Terjadi Force Majeur", index: 8),
        const TextFieldUploadFile(labelText: "Uraian Rencana Proyek (Proposal)", index: 9),
      ],
    );
  }
}
