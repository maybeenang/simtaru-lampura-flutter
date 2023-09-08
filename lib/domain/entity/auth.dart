import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';

@freezed
class Auth with _$Auth {
  const factory Auth.signedIn({
    required String id,
    required String nik,
    required String password,
    required String token,
  }) = SignedIn;

  const factory Auth.signedOut() = SignedOut;
}
