import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/widgets/other/status_chip.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:intl/intl.dart';

class ItemPengajuanCard extends StatelessWidget {
  const ItemPengajuanCard({super.key, required this.pengajuan});

  final Pengajuan pengajuan;

  @override
  Widget build(BuildContext context) {
    final formatedDate = DateFormat("dd MMMM yyyy", "id_ID").format(
      pengajuan.created_at.toLocal(),
    );

    return Container(
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
                DetailPengajuanRoute(pengajuan).go(context);
              },
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatusChip(statusId: pengajuan.status_id!),
              Container(
                padding: const EdgeInsets.fromLTRB(
                  15,
                  5,
                  10,
                  15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        pengajuan.nama_lengkap.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        pengajuan.rencana_penggunaan_tanah.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(formatedDate),
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
