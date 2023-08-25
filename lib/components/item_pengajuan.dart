import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/status_chip.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:go_router/go_router.dart';

class ItemPengajuan extends StatelessWidget {
  const ItemPengajuan({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/detail_pengajuan');
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: StatusChip(),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(
                20,
                5,
                10,
                15,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      "John Doe",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      "Bangunan Rumah dan Praktek Mandiri Keperawatan",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("12 Mei 2022"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
