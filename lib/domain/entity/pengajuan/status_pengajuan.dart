// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'status_pengajuan.freezed.dart';
part 'status_pengajuan.g.dart';

@freezed
class StatusPengajuan with _$StatusPengajuan {
  const factory StatusPengajuan({
    required int id,
    required String jenis_status,
    required String posisi_berkas,
  }) = _StatusPengajuan;

  factory StatusPengajuan.fromJson(Map<String, dynamic> json) =>
      _$StatusPengajuanFromJson(json);
}
