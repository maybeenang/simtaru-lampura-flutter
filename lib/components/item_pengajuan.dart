import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/status_chip.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class ItemPengajuan extends StatelessWidget {
  const ItemPengajuan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Elang Permadani",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 150,
                child: Text(
                  "Bangunan Rumah dan Praktek Mandiri Keperawatan",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text("12 Mei 2022"),
            ],
          ),
          StatusChip(),
        ],
      ),
    );
  }
}
