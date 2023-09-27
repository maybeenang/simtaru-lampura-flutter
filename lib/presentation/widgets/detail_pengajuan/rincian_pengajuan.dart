import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/controllers/status_pengajuan_controller.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RincianPengajuan extends ConsumerWidget {
  RincianPengajuan({super.key, required this.pengajuan});

  final Pengajuan pengajuan;

  final _mapColor = {
    1: AppColors.pengajuandiTolak,
    2: AppColors.pengajuandiProses,
    3: AppColors.pengajuandiProses,
    4: AppColors.pengajuandiProses,
    5: AppColors.pengajuandiProses,
    6: AppColors.pengajuandiProses,
    7: AppColors.pengajuandiProses,
    8: AppColors.pengajuandiProses,
    9: AppColors.pengajuandiProses,
    10: AppColors.pengajuandiProses,
    11: AppColors.pengajuandiProses,
    12: AppColors.pengajuanSelesai,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusState = ref.watch(statusPengajuanControllerProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDouble.paddingInside),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppDouble.borderRadius),
        boxShadow: [
          AppStyles.boxShadowStyle,
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Rincian Pengajuan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            color: AppColors.borderColor,
          ),
          const Text(
            "Status",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: statusState.maybeWhen(
                orElse: () => AppColors.whiteColor,
                data: (data) {
                  final color = _mapColor[
                      data.firstWhere((e) => e.id == pengajuan.status_id).id];

                  return color;
                },
              ),
              borderRadius: const BorderRadius.all(Radius.circular(3)),
            ),
            child: Text(
              statusState.maybeWhen(
                orElse: () => "Loading...",
                data: (data) {
                  final status = data
                      .firstWhere((e) => e.id == pengajuan.status_id)
                      .jenis_status
                      .toString();

                  return status;
                },
              ),
              style: const TextStyle(fontSize: 14, color: AppColors.whiteColor),
            ),
          ),
          const SizedBox(height: 10),
          pengajuan.status_id == 1
              ? const Text(
                  "Alasan Ditolak",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              : const SizedBox(),
          pengajuan.status_id == 1
              ? Text(
                  pengajuan.alasan_ditolak.toString(),
                  style: const TextStyle(fontSize: 16),
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          const Text(
            "Bertindak Atas Nama",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            pengajuan.bertindak_atas_nama.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "Penggunaan Tanah Saat Dimohon",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            pengajuan.penggunaan_tanah_saat_dimohon.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "Luas Tanah Seluruhnya",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "${pengajuan.luas_tanah_seluruhnya.toString()} m2",
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "Luas Tanah Yang Dimohon",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "${pengajuan.luas_tanah_yang_dimohon.toString()} m2",
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "Bukti Penguasaan Tanah",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            pengajuan.bukti_penguasaan_tanah.toString(),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
