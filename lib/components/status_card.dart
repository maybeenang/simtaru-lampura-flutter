import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class StatusCard extends StatelessWidget {
  StatusCard({super.key, required this.label});

  final String label;

  final Map<String, Color> colorMapping = {
    "Total Pengajuan": const Color(0xFF0891b2),
    "Pengajuan Disetujui": const Color(0xFF10b981),
    "Pengajuan Diproses": const Color(0xFFFF8800),
    "Pengajuan Ditolak": const Color(0xFFe11d48),
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorMapping[label],
      child: Container(
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width / 2.4,
        child: Row(
          children: [
            Column(
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
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
