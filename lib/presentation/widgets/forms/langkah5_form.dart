import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_uploadfile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Langkah5Form extends HookConsumerWidget {
  const Langkah5Form({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        const TextFieldUploadFile(labelText: "Fotocopy KTP", index: 0),
        const TextFieldUploadFile(labelText: "Fotocopy Sertifikat/Surat Tanah", index: 1),
        const TextFieldUploadFile(labelText: "Fotocopy SPPT PBB", index: 2),
        const TextFieldUploadFile(labelText: "Fotocopy NPWP", index: 3),
        const TextFieldUploadFile(
            labelText: "Surat Persetujuan Tetangga Dilampirkan FC KTP Diketahui Oleh Kades/Lurah & Camat", index: 4),
      ],
    );
  }
}
