import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_jumlah_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StatusCard extends HookConsumerWidget {
  StatusCard({super.key, required this.label});

  final String label;

  final Map<String, Color> colorMapping = {
    "Total Pengajuan": const Color(0xFF5b99e9),
    "Pengajuan Disetujui": const Color(0xFF98cc5f),
    "Pengajuan Diproses": const Color(0xFFfac44b),
    "Pengajuan Ditolak": const Color(0xFFe44d5c),
  };

  final Map<String, String> iconMapping = {
    "Total Pengajuan": "assets/svg/pengajuan_status/files-svgrepo-com.svg",
    "Pengajuan Disetujui": "assets/svg/pengajuan_status/file-text-svgrepo-com.svg",
    "Pengajuan Diproses": "assets/svg/pengajuan_status/file-edit-svgrepo-com.svg",
    "Pengajuan Ditolak": "assets/svg/pengajuan_status/file-remove-svgrepo-com.svg",
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jumlahPengajuanState = ref.watch(pengajuanJumlahControllerProvider);

    return Container(
      height: MediaQuery.of(context).size.height / 6,
      width: MediaQuery.of(context).size.width / 2.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconMapping[label]!,
            height: 40,
            width: 40,
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          Text(
            jumlahPengajuanState.when(
              data: (data) {
                if (label == "Total Pengajuan") {
                  return data.Seluruh.toString();
                } else if (label == "Pengajuan Disetujui") {
                  return data.Disetujui.toString();
                } else if (label == "Pengajuan Diproses") {
                  return data.Diproses.toString();
                } else if (label == "Pengajuan Ditolak") {
                  return data.Ditolak.toString();
                } else {
                  return '0';
                }
              },
              loading: () => '0',
              error: (e, s) => '0',
            ),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );

    // return Container(
    //   height: MediaQuery.of(context).size.height / 6,
    //   width: MediaQuery.of(context).size.width / 2.3,
    //   margin: const EdgeInsets.all(5),
    //   clipBehavior: Clip.antiAlias,
    //   decoration: BoxDecoration(
    //     color: colorMapping[label],
    //     borderRadius: BorderRadius.circular(AppDouble.borderRadius),
    //     boxShadow: [
    //       BoxShadow(
    //         color: colorMapping[label]!.withOpacity(0.95),
    //         blurRadius: 12.5,
    //         offset: const Offset(0, 5),
    //       ),
    //     ],
    //   ),
    //   child: Material(
    //     color: Colors.transparent,
    //     child: InkWell(
    //       onTap: () {
    //         ref.read(indexScreenProvider.notifier).onIndexChange(1);
    //         ref.read(controllerNavbarProvider).index = 1;
    //       },
    //       child: Stack(
    //         children: [
    //           Align(
    //             alignment: Alignment.centerRight,
    //             child: Icon(
    //               iconMapping[label],
    //               color: Colors.black.withOpacity(0.05),
    //               size: 150,
    //             ),
    //           ),
    //           Container(
    //             padding: const EdgeInsets.all(15),
    //             width: MediaQuery.of(context).size.width / 2.4,
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   jumlahPengajuanState.when(
    //                     data: (data) {
    //                       if (label == "Total Pengajuan") {
    //                         return data.Seluruh.toString();
    //                       } else if (label == "Pengajuan Disetujui") {
    //                         return data.Disetujui.toString();
    //                       } else if (label == "Pengajuan Diproses") {
    //                         return data.Diproses.toString();
    //                       } else if (label == "Pengajuan Ditolak") {
    //                         return data.Ditolak.toString();
    //                       } else {
    //                         return '0';
    //                       }
    //                     },
    //                     loading: () => '0',
    //                     error: (e, s) => '0',
    //                   ),
    //                   style: const TextStyle(
    //                     color: AppColors.whiteColor,
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 const SizedBox(height: 10),
    //                 Text(
    //                   label,
    //                   maxLines: 2,
    //                   overflow: TextOverflow.ellipsis,
    //                   style: const TextStyle(
    //                     color: AppColors.whiteColor,
    //                     fontWeight: FontWeight.w600,
    //                     fontSize: 14,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
