// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'jumlah_pengajuan.freezed.dart';
part 'jumlah_pengajuan.g.dart';

@freezed
class JumlahPengajuan with _$JumlahPengajuan {
  const factory JumlahPengajuan({
    required int Seluruh,
    required int Ditolak,
    required int Disetujui,
    required int Diproses,
  }) = _JumlahPengajuan;

  factory JumlahPengajuan.fromJson(Map<String, dynamic> json) => _$JumlahPengajuanFromJson(json);
}
