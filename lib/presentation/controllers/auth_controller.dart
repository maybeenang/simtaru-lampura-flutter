import 'package:flutter_map_simtaru/domain/entity/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_controller.g.dart';

const _dummyUser = Auth.signedIn(
  id: 'id',
  nik: 'nik',
  password: 'password',
  token: 'token',
);

@riverpod
class AuthController extends _$AuthController {
  late SharedPreferences _sharedPreferences;
  static const _sharedPrefsKey = 'token';

  @override
  Future<Auth> build() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    _persistentRefreshLogic();

    return _loginRecoveryAttemp();
  }

  Future<Auth> _loginRecoveryAttemp() async {
    try {
      final token = _sharedPreferences.getString(_sharedPrefsKey);

      if (token == null) {
        throw Exception('No token found');
      }

      return _loginWithToken(token);
    } catch (e) {
      await _sharedPreferences.remove(_sharedPrefsKey);
      return const Auth.signedOut();
    }
  }

  Future<Auth> _loginWithToken(String token) async {
    final logInAttempt = await Future.delayed(
      const Duration(milliseconds: 750),
      () => true, // edit this if you wanna play around
    );

    if (logInAttempt) return _dummyUser;

    throw Exception('Invalid token');
  }

  Future<void> login(String nik, String password) async {
    state = const AsyncValue<Auth>.loading();
    state = await AsyncValue.guard<Auth>(
      () async {
        return await Future.delayed(
          const Duration(seconds: 5),
          () => _dummyUser,
        );
      },
    );
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 750));
    state = const AsyncValue<Auth>.data(Auth.signedOut());
  }

  void _persistentRefreshLogic() {
    ref.listenSelf(
      (_, next) {
        if (next.isLoading) return;
        if (next.hasError) {
          _sharedPreferences.remove(_sharedPrefsKey);
          return;
        }

        next.requireValue.map<void>(
          signedIn: (signedIn) async {
            await _sharedPreferences.setString(_sharedPrefsKey, signedIn.token);
          },
          signedOut: (signedOut) async {
            await _sharedPreferences.remove(_sharedPrefsKey);
          },
        );
      },
    );
  }
}
