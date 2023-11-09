import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/widgets/other/status_chip.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ItemPengajuanCard extends HookConsumerWidget {
  const ItemPengajuanCard({super.key, required this.pengajuan, this.onTap});

  final Pengajuan pengajuan;
  final Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Future setujuiPengajuan(BuildContext context, int pengajuanId, String pengajuanNama) async {
    //   showCupertinoDialog(
    //     context: context,
    //     builder: (context) {
    //       return CupertinoAlertDialog(
    //         title: const Text("Peringatan"),
    //         content: Text('Anda yakin pengajuan atas nama $pengajuanNama, lolos verifikasi berkas?'),
    //         actions: [
    //           CupertinoDialogAction(
    //             child: const Text("Batal"),
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //           ),
    //           CupertinoDialogAction(
    //             child: const Text("Ya"),
    //             onPressed: () async {
    //               Navigator.pop(context);
    //               await ref.read(pengajuanControllerProvider.notifier).setujuiPengajuan(pengajuanId = pengajuan.id);
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    // void onTapVerifikasiBerkas(BuildContext context) {
    //   Future.delayed(
    //     const Duration(milliseconds: 100),
    //     () => showModalBottomSheet(
    //       context: context,
    //       builder: (context) {
    //         return BottomSheetCard(
    //           pengajuan: pengajuan,
    //           actions: [
    //             ButtonActionPengajuan(
    //               label: "Setujui",
    //               icon: Icons.check,
    //               color: AppColors.greenColor,
    //               onTap: () async {
    //                 Navigator.pop(context);

    //                 setujuiPengajuan(context, pengajuan.id, pengajuan.nama_lengkap!);
    //               },
    //             ),
    //             const SizedBox(height: 5),
    //             ButtonActionPengajuan(
    //               label: "Tolak",
    //               icon: Icons.close,
    //               color: AppColors.redColor,
    //               onTap: () {
    //                 Navigator.pop(context);

    //                 // tolakPengajuan(pengajuan.id, pengajuan.nama_lengkap!);
    //               },
    //             ),
    //             const SizedBox(height: 5),
    //             ButtonActionPengajuan(
    //               label: "Edit",
    //               icon: Icons.edit,
    //               color: AppColors.mapColorStatusChip[2]!,
    //               onTap: () {
    //                 Navigator.pop(context);

    //                 AdminEditPengajuanRoute(pengajuan).push(context);
    //               },
    //             ),
    //           ],
    //         );
    //       },
    //     ),
    //   );
    // }

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
          onTap: onTap ??
              () {
                Future.delayed(
                  const Duration(milliseconds: 300),
                  () {
                    DetailPengajuanRoute(pengajuan).push(context);
                  },
                );
              },
          // onTap: () {
          //   onTapVerifikasiBerkas(context);
          // },
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
                          fontWeight: FontWeight.w600,
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
