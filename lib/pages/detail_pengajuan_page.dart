import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/custom_safe_area.dart';
import 'package:flutter_map_simtaru/components/detail_pengajuan/biodata_pemohon.dart';
import 'package:flutter_map_simtaru/components/detail_pengajuan/rencana_pembangunan.dart';
import 'package:flutter_map_simtaru/components/detail_pengajuan/rincian_dokumen.dart';
import 'package:flutter_map_simtaru/components/detail_pengajuan/rincian_pengajuan.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:go_router/go_router.dart';

class DetailPengajuanPage extends StatelessWidget {
  const DetailPengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      color: AppColors.bgColor,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  color: AppColors.bgColor,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        "Detail Pengajuan",
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const BiodataPemohon(),
                const SizedBox(height: 10),
                const RincianPengajuan(),
                const SizedBox(height: 10),
                const RencanaPembangunan(),
                const SizedBox(height: 10),
                const RincianDokumen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
