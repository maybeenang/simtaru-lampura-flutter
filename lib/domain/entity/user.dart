// ignore_for_file: non_constant_identifier_names, invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory User({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'is_active') required int is_active,
    @JsonKey(name: 'no_ktp') required String no_ktp,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'profile_photo_path') required String profile_photo_path,
    @JsonKey(name: 'profile_photo_url') required String profile_photo_url,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
