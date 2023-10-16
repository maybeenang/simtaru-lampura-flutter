import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_jumlah_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StatusPengajuanCard extends HookConsumerWidget {
  StatusPengajuanCard({super.key, required this.label});

  final String label;

  final Map<String, Color> colorMapping = {
    "Total Pengajuan": const Color(0xFF5b99e9),
    "Pengajuan Disetujui": const Color(0xFF98cc5f),
    "Pengajuan Diproses": const Color(0xFFfac44b),
    "Pengajuan Ditolak": const Color(0xFFe44d5c),
  };

  final Map<String, IconData> iconMapping = {
    "Total Pengajuan": Icons.assignment_sharp,
    "Pengajuan Disetujui": Icons.check_circle_outline,
    "Pengajuan Diproses": Icons.pending_outlined,
    "Pengajuan Ditolak": Icons.cancel_outlined,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jumlahPengajuanState = ref.watch(pengajuanJumlahControllerProvider);

    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDouble.borderRadius),
        color: colorMapping[label],
        boxShadow: [
          BoxShadow(
            color: colorMapping[label]!.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              iconMapping[label],
              color: Colors.black.withOpacity(0.1),
              size: 200,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      jumlahPengajuanState.when(
                        data: (data) {
                          if (label == "Total Pengajuan") {
                            return data.Seluruh.toString();
                          } else if (label == "Pengajuan Disetujui") {
                            return data.Disetujui.toString();
                          } else if (label == "Pengajuan Diproses") {
                            return data.Diproses.toString();
                          } else if (label == "Pengajuan Ditolak") {
                            return data.Ditolak.toString();
                          } else {
                            return '0';
                          }
                        },
                        loading: () => '0',
                        error: (e, s) => '0',
                      ),
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      label,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
