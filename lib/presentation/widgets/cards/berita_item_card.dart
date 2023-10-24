import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/domain/entity/artikel/artikel.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:intl/intl.dart';

class BeritaItemCard extends StatelessWidget {
  const BeritaItemCard({super.key, required this.artikel});

  final Artikel artikel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(AppDouble.borderRadius),
          boxShadow: [
            AppStyles.boxShadowStyle,
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Future.delayed(
                const Duration(milliseconds: 300),
                () {
                  DetailBeritaRoute(artikel).go(context);
                },
              );
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        artikel.judul,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            DateFormat('yyyy-MM-dd').format(artikel.created_at),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        artikel.isi,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
