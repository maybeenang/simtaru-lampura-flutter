import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class DetailPengajuanPage extends StatelessWidget {
  const DetailPengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pengajuan"),
      ),
      body: SingleChildScrollView(
        child: Accordion(
          openAndCloseAnimation: false,
          headerBackgroundColor: AppColors.primaryColor,
          headerBorderRadius: 3,
          children: [
            AccordionSection(
              contentBorderRadius: 3,
              header: const Text(
                "Profile",
                style: TextStyle(color: AppColors.whiteColor),
              ),
              content: Table(
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
                    Text("Rizky"),
                  ]),
                  TableRow(children: [
                    Text("NIP"),
                    Text(":"),
                    Text("123456789"),
                  ]),
                  TableRow(children: [
                    Text("Jabatan"),
                    Text(":"),
                    Text("Kepala Dinas"),
                  ]),
                  TableRow(children: [
                    Text("Unit Kerja"),
                    Text(":"),
                    Text("Dinas Pendidikan"),
                  ]),
                  TableRow(children: [
                    Text("Alamat"),
                    Text(":"),
                    Text("Jl. Raya"),
                  ]),
                  TableRow(children: [
                    Text("No. HP"),
                    Text(":"),
                    Text("08123456789"),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
