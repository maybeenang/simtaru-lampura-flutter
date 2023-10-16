// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'notif_pengajuan.freezed.dart';
part 'notif_pengajuan.g.dart';

@freezed
class NotifPengajuan with _$NotifPengajuan {
  const factory NotifPengajuan({
    required int Total,
  }) = _NotifPengajuan;

  factory NotifPengajuan.fromJson(Map<String, dynamic> json) => _$NotifPengajuanFromJson(json);
}
