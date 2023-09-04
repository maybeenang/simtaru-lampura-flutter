import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:flutter_map_simtaru/constants/double.dart';

class StatusCard extends StatelessWidget {
  StatusCard({super.key, required this.label});

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
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height / 7,
          width: MediaQuery.of(context).size.width / 2.3,
          margin: const EdgeInsets.all(5),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: colorMapping[label],
            borderRadius: BorderRadius.circular(AppDouble.borderRadius),
            boxShadow: [
              BoxShadow(
                color: colorMapping[label]!.withOpacity(0.95),
                blurRadius: 12.5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  iconMapping[label],
                  color: Colors.black.withOpacity(0.05),
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
