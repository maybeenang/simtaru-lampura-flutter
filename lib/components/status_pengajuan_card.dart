import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class StatusPengajuanCard extends StatelessWidget {
  StatusPengajuanCard({super.key, required this.label});

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
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: colorMapping[label],
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
                    const Text(
                      "0",
                      style: TextStyle(
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
                        fontSize: 24,
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
