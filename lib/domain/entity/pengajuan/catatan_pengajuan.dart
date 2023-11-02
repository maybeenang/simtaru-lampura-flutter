// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'catatan_pengajuan.freezed.dart';
part 'catatan_pengajuan.g.dart';

@freezed
class CatatanPengajuan with _$CatatanPengajuan {
  const factory CatatanPengajuan({
    required int id,
    required dynamic pengajuan_id,
    required String keterangan,
    required DateTime created_at,
    required DateTime updated_at,
  }) = _CatatanPengajuan;

  factory CatatanPengajuan.fromJson(Map<String, dynamic> json) => _$CatatanPengajuanFromJson(json);
}
