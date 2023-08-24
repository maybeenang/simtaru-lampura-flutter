import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/pengajuan_accordion_section.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class DetailPengajuanPage extends StatelessWidget {
  const DetailPengajuanPage({super.key});

  List<AccordionSection> _buildAccordionSection() {
    return [
      AccordionSection(
        contentBorderRadius: 3,
        isOpen: true,
        header: const Text(
          "Biodata Pemohon",
          style: TextStyle(color: AppColors.whiteColor),
        ),
        content: PengajuanTableSection(),
      ),
      AccordionSection(
        contentBorderRadius: 3,
        isOpen: true,
        header: const Text(
          "Biodata Pemohon",
          style: TextStyle(color: AppColors.whiteColor),
        ),
        content: PengajuanTableSection(),
      ),
      AccordionSection(
        contentBorderRadius: 3,
        isOpen: true,
        header: const Text(
          "Biodata Pemohon",
          style: TextStyle(color: AppColors.whiteColor),
        ),
        content: PengajuanTableSection(),
      ),
      AccordionSection(
        contentBorderRadius: 3,
        isOpen: true,
        header: const Text(
          "Biodata Pemohon",
          style: TextStyle(color: AppColors.whiteColor),
        ),
        content: PengajuanTableSection(),
      ),
    ];
  }

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
            ..._buildAccordionSection(),
          ],
        ),
      ),
    );
  }
}
