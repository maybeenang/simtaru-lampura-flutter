import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class StatusCard extends StatelessWidget {
  StatusCard({super.key, required this.label});

  final String label;

  final Map<String, Color> colorMapping = {
    "Total Pengajuan": const Color(0xFF06b6d4),
    "Pengajuan Disetujui": const Color(0xFF10b981),
    "Pengajuan Diproses": const Color(0xFFFF8800),
    "Pengajuan Ditolak": const Color(0xFFe11d48),
  };

  final Map<String, IconData> iconMapping = {
    "Total Pengajuan": Icons.assignment_sharp,
    "Pengajuan Disetujui": Icons.check_circle_outline,
    "Pengajuan Diproses": Icons.pending_outlined,
    "Pengajuan Ditolak": Icons.cancel_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width / 2.4,
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colorMapping[label],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              iconMapping[label],
              color: Colors.black.withOpacity(0.1),
              size: 150,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width / 2.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "0",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
