import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/domain/entity/role/role.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_jumlah_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_user_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/roles/role_provider.dart';
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
    final roleState = ref.watch(roleProvider);
    final pengajuanUser = ref.watch(pengajuanUserControllerProvider);

    return SizedBox(
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
                  if (roleState is User) {
                    return pengajuanUser.when(
                      data: (data) {
                        return data.length.toString();
                      },
                      loading: () => '0',
                      error: (e, s) => '0',
                    );
                  }
                  return data.Seluruh.toString();
                } else if (label == "Pengajuan Disetujui") {
                  if (roleState is User) {
                    return pengajuanUser.when(
                      data: (data) {
                        if (data.isEmpty) {
                          return '0';
                        }
                        return data.where((element) => element.status_id == 12).length.toString();
                      },
                      loading: () => '0',
                      error: (e, s) => '0',
                    );
                  }
                  return data.Disetujui.toString();
                } else if (label == "Pengajuan Diproses") {
                  if (roleState is User) {
                    return pengajuanUser.when(
                      data: (data) {
                        if (data.isEmpty) {
                          return '0';
                        }
                        return data.where((element) => element.status_id != 1 && element.status_id != 12).length.toString();
                      },
                      loading: () => '0',
                      error: (e, s) => '0',
                    );
                  }
                  return data.Diproses.toString();
                } else if (label == "Pengajuan Ditolak") {
                  if (roleState is User) {
                    return pengajuanUser.when(
                      data: (data) {
                        if (data.isEmpty) {
                          return '0';
                        }
                        return data.where((element) => element.status_id == 1).length.toString();
                      },
                      loading: () => '0',
                      error: (e, s) => '0',
                    );
                  }
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
  }
}
