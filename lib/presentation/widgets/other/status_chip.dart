import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/controllers/status_pengajuan_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StatusChip extends ConsumerWidget {
  StatusChip({super.key, required this.statusId});

  final int statusId;

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
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: statusState.maybeWhen(
          orElse: () => AppColors.whiteColor,
          data: (data) {
            final color =
                _mapColor[data.firstWhere((e) => e.id == statusId).id];

            return color;
          },
        ),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
      ),
      child: Text(
        statusState.maybeWhen(
          orElse: () => "Loading...",
          data: (data) {
            final status = data
                .firstWhere((e) => e.id == statusId)
                .jenis_status
                .toString();

            return status;
          },
        ),
        style: const TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
