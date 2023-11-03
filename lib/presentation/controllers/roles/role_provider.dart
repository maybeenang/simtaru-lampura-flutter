import 'package:flutter_map_simtaru/domain/entity/role/role.dart';
import 'package:flutter_map_simtaru/domain/entity/role/role_dto.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/presentation/controllers/roles/role_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'role_provider.g.dart';

@riverpod
Role role(RoleRef ref) {
  final userState = ref.watch(userControllerProvider);
  final roleState = ref.watch(roleControllerProvider);

  final roleDto = roleState.maybeWhen(
    orElse: () => [],
    data: (data) => data,
  );

  return userState.maybeWhen(
    orElse: () => const Role.user(),
    data: (data) {
      if (data is UserSuccess) {
        if (roleDto.isEmpty) {
          return const Role.user();
        }

        if (data.model.roles!.isEmpty) {
          return const Role.user();
        }

        // if (data.model.roles!.isEmpty) {
        //   return const Role.user();
        // }

        // final role = roleDto.firstWhere(
        //   (element) => element.id == data.model.roles!.first['id'],
        //   orElse: () => const Role.user(),
        // );

        // switch (data.model.roles!.first['id']) {
        //   case 6:
        //     return const Role.user();
        //   default:
        //     return const Role.admin();
        // }

        RoleDto namaRole = roleDto.firstWhere(
          (element) => element.id == data.model.roles!.first['id'],
          orElse: () => const RoleDto(id: 6, name: "Pemohon"),
        );

        switch (namaRole.name) {
          case "Superadmin":
            return const Role.admin();
          case "Sekretariat-TKPRD":
            return const Role.admin();
          case "Pokja-PRPPR":
            return const Role.admin();
          case "Ketua-TKPRD":
            return const Role.admin();
          case "Kepala-Dinas-PUPR":
            return const Role.admin();
          case "Pemohon":
            return const Role.user();
          case "Admin Verif Berkas":
            return const Role.adminVerifBerkas();
          case "Admin Verif Lapangan":
            return const Role.adminVerifLapangan();
          case "Admin Upload Scan Surat":
            return const Role.adminUploadScanSurat();
          case "Admin Surveyor":
            return const Role.surveyor();
          default:
            return const Role.user();
        }
      } else {
        return const Role.user();
      }
    },
  );
}
