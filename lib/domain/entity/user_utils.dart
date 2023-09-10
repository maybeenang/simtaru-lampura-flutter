import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_utils.freezed.dart';
part 'user_utils.g.dart';

@freezed
class UserUtils with _$UserUtils {
  const factory UserUtils({
    required int id,
    required String name,
    @Default(0) int? is_active,
    required int no_ktp,
    required String email,
    @Default("") String? profile_photo_path,
    required String profile_photo_url,
  }) = _UserUtils;

  factory UserUtils.fromJson(Map<String, dynamic> json) =>
      _$UserUtilsFromJson(json);
}
