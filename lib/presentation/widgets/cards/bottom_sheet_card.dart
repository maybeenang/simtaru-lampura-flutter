import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_action_pengajuan.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomSheetCard extends ConsumerWidget {
  const BottomSheetCard({super.key, required this.pengajuan});

  final Pengajuan pengajuan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Action",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          ButtonActionPengajuan(
            label: "Lihat Detail",
            icon: Icons.document_scanner_outlined,
            color: AppColors.primaryColor,
            onTap: () {
              Future.delayed(
                const Duration(milliseconds: 300),
                () {
                  Navigator.pop(context);
                  DetailPengajuanRoute(pengajuan).push(context);
                },
              );
            },
          ),
          const SizedBox(height: 10),
          const Divider(
            endIndent: 10,
            indent: 10,
          ),
          const SizedBox(height: 10),
          const ButtonActionPengajuan(
            label: "Setujui",
            icon: Icons.check,
            color: AppColors.greenColor,
          ),
          const SizedBox(height: 5),
          const ButtonActionPengajuan(
            label: "Tolak",
            icon: Icons.close,
            color: AppColors.redColor,
          ),
          const SizedBox(height: 5),
          ButtonActionPengajuan(
            label: "Edit",
            icon: Icons.edit,
            color: AppColors.mapColorStatusChip[2]!,
          ),
        ],
      ),
    );
  }
}
