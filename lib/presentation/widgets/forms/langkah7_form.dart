import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/pengajuan/pengajuan_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Langkah7Form extends HookConsumerWidget {
  const Langkah7Form({super.key, required this.inputController});

  final List inputController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currLatLngState = ref.watch(currLatLng);
    final inputsFileState = ref.watch(inputsFile);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.redColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(3),
          ),
          child: const Text(
            "Pengajuan ini akan diproses oleh pihak terkait. Pastikan data yang anda masukkan sudah benar.",
            style: TextStyle(
              color: AppColors.redColor,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text("Ringkasan", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        const Divider(),
        const Text(
          "Nama Lengkap",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(inputController[0].text),
        const SizedBox(height: 5),
        const Text(
          "Tempat, Tanggal Lahir",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(inputController[1].text),
        const SizedBox(height: 5),
        const Text(
          "Alamat",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(inputController[2].text),
        const SizedBox(height: 5),
        const Text(
          "Pekerjaan",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(inputController[3].text),
        const SizedBox(height: 5),
        const Text(
          "No. Identitas",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(inputController[4].text),
        const SizedBox(height: 5),
        const Text(
          "No. HP",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(inputController[5].text),
        const SizedBox(height: 5),
        const Text(
          "Bertindak atas nama",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(inputController[6].text),
        const SizedBox(height: 5),
        const Text(
          "Penggunaan Tanah Saat Dimohon",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(inputController[7].text),
        const SizedBox(height: 5),
        const Text(
          "Luas Tanah Seluruhnya m2",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text('${inputController[8].text} m2'),
        const SizedBox(height: 5),
        const Text(
          "Luas Tanah yang dimohon m2",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text('${inputController[9].text} m2'),
        const SizedBox(height: 5),
        const Text(
          "Bukti Penguasaan Tanah",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(inputController[10].text),
        const SizedBox(height: 5),
        const Text(
          "Letak Tanah",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(inputController[11].text),
        const SizedBox(height: 5),
        const Text(
          "Rencana Penggunaan Tanah",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(inputController[12].text),
        const SizedBox(height: 5),
        const Text(
          "Batas Sebelah Utara",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(inputController[13].text),
        const SizedBox(height: 5),
        const Text(
          "Batas Sebelah Timur",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(inputController[14].text),
        const SizedBox(height: 5),
        const Text(
          "Batas Sebelah Selatan",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(inputController[15].text),
        const SizedBox(height: 5),
        const Text(
          "Batas Sebelah Barat",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(inputController[16].text),
        const SizedBox(height: 5),
        const Text(
          "Koordinat",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(currLatLngState.toString()),
        const SizedBox(height: 5),
        const Text(
          "Foto",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(inputsFileState[0].toString()),
      ],
    );
  }
}
