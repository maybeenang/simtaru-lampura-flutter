import 'package:flutter_map_simtaru/domain/entity/user_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User.success(UserUtils model) = UserSuccess;

  const factory User.error(String massage) = UserError;
}
