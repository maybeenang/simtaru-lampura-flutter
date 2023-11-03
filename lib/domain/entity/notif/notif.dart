// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notif.freezed.dart';
part 'notif.g.dart';

@freezed
class Notif with _$Notif {
  const factory Notif({
    required int id,
    required int user_id,
    required String judul,
    required String keterangan,
    required int dilihat,
    required DateTime created_at,
    required DateTime updated_at,
  }) = _Notif;

  factory Notif.fromJson(Map<String, dynamic> json) => _$NotifFromJson(json);
}
