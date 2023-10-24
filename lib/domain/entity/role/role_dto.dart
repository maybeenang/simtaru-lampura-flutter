// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'role_dto.freezed.dart';
part 'role_dto.g.dart';

@freezed
class RoleDto with _$RoleDto {
  const factory RoleDto({
    required int id,
    required String name,
    required String guard_name,
    required String created_at,
    required String updated_at,
  }) = _RoleDto;

  factory RoleDto.fromJson(Map<String, dynamic> json) => _$RoleDtoFromJson(json);
}
