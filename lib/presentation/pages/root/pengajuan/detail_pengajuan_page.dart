import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/domain/entity/role/role.dart';
import 'package:flutter_map_simtaru/presentation/controllers/roles/role_provider.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:flutter_map_simtaru/presentation/widgets/detail_pengajuan/biodata_pemohon.dart';
import 'package:flutter_map_simtaru/presentation/widgets/detail_pengajuan/data_lapangan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/detail_pengajuan/rencana_pembangunan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/detail_pengajuan/rincian_dokumen.dart';
import 'package:flutter_map_simtaru/presentation/widgets/detail_pengajuan/rincian_pengajuan.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailPengajuanPage extends HookConsumerWidget {
  const DetailPengajuanPage({super.key, required this.pengajuan});

  final Pengajuan pengajuan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleState = ref.watch(roleProvider);

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
                RincianDokumen(pengajuan: pengajuan),
                const SizedBox(height: 20),
                roleState is Surveyor
                    ? Column(
                        children: [
                          const SizedBox(width: double.infinity, child: Text("Surveyor : ")),
                          const SizedBox(height: 10),
                          DataLapangan(pengajuan: pengajuan),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
