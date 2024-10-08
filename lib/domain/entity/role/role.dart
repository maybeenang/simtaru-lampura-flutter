import 'package:freezed_annotation/freezed_annotation.dart';

part 'role.freezed.dart';

@freezed
class Role with _$Role {
  const factory Role.admin() = Admin;
  const factory Role.adminVerifBerkas() = AdminVerifBerkas;
  const factory Role.adminVerifLapangan() = AdminVerifLapangan;
  const factory Role.adminUploadScanSurat() = AdminUploadScanSurat;

  const factory Role.user() = User;
  const factory Role.surveyor() = Surveyor;
}
