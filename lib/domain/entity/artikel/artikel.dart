// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'artikel.freezed.dart';
part 'artikel.g.dart';

@freezed
class Artikel with _$Artikel {
  const factory Artikel({
    required int id,
    required String judul,
    required String isi,
    required DateTime created_at,
    required DateTime updated_at,
  }) = _Artikel;

  factory Artikel.fromJson(Map<String, dynamic> json) => _$ArtikelFromJson(json);
}
