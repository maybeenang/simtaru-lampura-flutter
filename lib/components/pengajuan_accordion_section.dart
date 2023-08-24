import 'package:accordion/accordion_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class PengajuanTableSection extends StatelessWidget {
  const PengajuanTableSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: Map.from(
        {
          0: const FlexColumnWidth(1),
          1: const FlexColumnWidth(0.1),
          2: const FlexColumnWidth(2),
        },
      ),
      children: const [
        TableRow(children: [
          Text("Nama"),
          Text(":"),
          Text("John Doe"),
        ]),
        TableRow(children: [
          Text("No. KTP/NIK"),
          Text(":"),
          Text("1871025108990006"),
        ]),
        TableRow(children: [
          Text("Alamat"),
          Text(":"),
          Text(
              "Jl.Griya Kencana Blok K No.5 LK.II RT/RW 003/000, Kelurahan Wayhalim Permai, Kecamatan Way Halim, Kota Bandar Lampung"),
        ]),
        TableRow(children: [
          Text("Tempat Tanggal Lahir"),
          Text(":"),
          Text("Bandar Lampung, 11-08-1999"),
        ]),
        TableRow(children: [
          Text("Pekerjaan"),
          Text(":"),
          Text("Pelajar/ Mahasiswa"),
        ]),
        TableRow(children: [
          Text("No. HP"),
          Text(":"),
          Text("082280136688"),
        ]),
      ],
    );
  }
}
