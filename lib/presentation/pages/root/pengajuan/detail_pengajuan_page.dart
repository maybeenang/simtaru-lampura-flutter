import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:flutter_map_simtaru/presentation/widgets/detail_pengajuan/biodata_pemohon.dart';
import 'package:flutter_map_simtaru/presentation/widgets/detail_pengajuan/rencana_pembangunan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/detail_pengajuan/rincian_dokumen.dart';
import 'package:flutter_map_simtaru/presentation/widgets/detail_pengajuan/rincian_pengajuan.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:go_router/go_router.dart';

class DetailPengajuanPage extends StatelessWidget {
  const DetailPengajuanPage({super.key, required this.pengajuan});

  final Pengajuan pengajuan;

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
                BiodataPemohon(pengajuan: pengajuan),
                const SizedBox(height: 10),
                RincianPengajuan(pengajuan: pengajuan),
                const SizedBox(height: 10),
                RencanaPembangunan(pengajuan: pengajuan),
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
