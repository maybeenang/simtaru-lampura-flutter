import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';

@freezed
class Auth with _$Auth {
  const factory Auth.signedIn({
    @Default('') String nip,
    @Default('') String password,
    @Default('') String token,
  }) = SignedIn;

  const factory Auth.signedOut() = SignedOut;
  const factory Auth.signedUp() = SignedUp;
  const factory Auth.error(
    String message,
  ) = Error;
}
