import 'dart:async';

import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/domain/entity/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  late SharedPreferences _sharedPreferences;
  static const _sharedPrefsKey = 'token';
  final Dio dio = Dio();

  @override
  Future<Auth> build() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    _persistentRefreshLogic();

    return _loginRecoveryAttemp();
  }

  Future<Auth> _loginRecoveryAttemp() async {
    try {
      state = const AsyncValue<Auth>.loading();
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
    state = const AsyncValue<Auth>.loading();

    final loginAttemp = await AsyncValue.guard<Auth>(
      () async {
        final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.refresh);
        final Response response = await dio.post(
          uri.toString(),
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ),
        );
        final data = response.data;
        final accessToken = data['data']['original']['access_token'];
        await _sharedPreferences.setString(_sharedPrefsKey, accessToken);
        final Auth auth = Auth.signedIn(
          token: accessToken,
        );
        return auth;
      },
    );

    if (loginAttemp is AsyncError<Auth>) {
      await _sharedPreferences.remove(_sharedPrefsKey);
      return const Auth.signedOut();
    } else {
      final accessToken = _sharedPreferences.getString(_sharedPrefsKey);
      return Auth.signedIn(
        token: accessToken ?? '',
      );
    }
  }

  Future<void> login(String nik, String password) async {
    state = const AsyncValue<Auth>.loading();
    state = await AsyncValue.guard<Auth>(
      () async {
        final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.login);
        final Response response = await dio.post(
          uri.toString(),
          data: {
            'no_ktp': nik,
            'password': password,
          },
        );
        final data = response.data;
        final token = data['data']['original']['access_token'];
        await _sharedPreferences.setString(_sharedPrefsKey, token);
        final Auth auth = Auth.signedIn(
          token: token,
        );
        return auth;
      },
    );
  }

  Future<void> logout() async {
    state = const AsyncValue<Auth>.loading();
    state = await AsyncValue.guard<Auth>(
      () async {
        final token = _sharedPreferences.getString(_sharedPrefsKey);
        final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.logout);
        await dio.post(
          uri.toString(),
          options: Options(
            headers: {
              "Authorization": "Bearer ${token ?? ''}",
            },
          ),
        );
        await _sharedPreferences.remove(_sharedPrefsKey);
        const Auth auth = Auth.signedOut();
        return auth;
      },
    );
  }

  Future<void> register(
    String nik,
    String nama,
    String email,
    String password,
  ) async {
    state = const AsyncValue<Auth>.loading();
    state = await AsyncValue.guard<Auth>(() {
      final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.register);
      return dio.post(
        uri.toString(),
        data: {
          'no_ktp': nik,
          'name': nama,
          'email': email,
          'password': password,
        },
      ).then((value) {
        const Auth auth = Auth.signedUp();
        return auth;
      });
    });
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
          signedUp: (value) {},
        );
      },
    );
  }
}
