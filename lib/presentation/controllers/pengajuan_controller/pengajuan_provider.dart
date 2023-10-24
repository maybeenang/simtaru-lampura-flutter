import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/domain/entity/role/role_dto.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_upload_scan_surat_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_user_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_verifikasi_berkas_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_verifikasi_lapangan_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/roles/role_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pengajuan_provider.g.dart';

@riverpod
AsyncValue<List<Pengajuan>?> pengajuanProvider(PengajuanProviderRef ref) {
  final userState = ref.watch(userControllerProvider);
  final roleState = ref.watch(roleControllerProvider);

  final roleDto = roleState.maybeWhen(
    orElse: () => [],
    data: (data) => data,
  );

  return userState.maybeWhen(
    orElse: () => ref.watch(pengajuanUserControllerProvider),
    data: (data) {
      if (data is UserSuccess) {
        if (roleDto.isEmpty) {
          return ref.watch(pengajuanUserControllerProvider);
        }

        if (data.model.roles!.isEmpty) {
          return ref.watch(pengajuanUserControllerProvider);
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
            return ref.watch(pengajuanControllerProvider);
          case "Pemohon":
            return ref.watch(pengajuanUserControllerProvider);
          case "Admin Verif Berkas":
            return ref.watch(pengajuanVerifikasiBerkasControllerProvider);
          case "Admin Verif Lapangan":
            return ref.watch(pengajuanVerifikasiLapanganControllerProvider);
          case "Admin Upload Scan Surat":
            return ref.watch(pengajuanUploadScanSuratControllerProvider);
          case "Surveyor":
            return ref.watch(pengajuanUserControllerProvider);
          default:
            return ref.watch(pengajuanUserControllerProvider);
        }
      } else {
        return ref.watch(pengajuanUserControllerProvider);
      }
    },
  );
}
