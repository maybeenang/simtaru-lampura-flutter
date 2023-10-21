// ignore_for_file: unused_element

import 'dart:async';

import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/domain/entity/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  late SharedPreferences _sharedPreferences;
  static const _sharedPrefsKey = 'token';
  static const _sharedPrefsNipKey = 'nip';
  static const _sharedPrefsPasswordKey = 'password';
  final Dio dio = Dio();

  @override
  Future<Auth> build() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    _persistentRefreshLogic();

    return _loginRecoveryAttemp();
  }

  void _persistentRefreshLogic() {
    ref.listenSelf(
      (_, next) {
        if (next.isLoading) return;

        print("next ${next}");

        next.requireValue.map<void>(
          signedIn: (signedIn) async {
            await _sharedPreferences.setString(_sharedPrefsKey, signedIn.token);
            await _sharedPreferences.setString(_sharedPrefsNipKey, signedIn.nip);
            await _sharedPreferences.setString(_sharedPrefsPasswordKey, signedIn.password);
          },
          signedOut: (signedOut) async {
            await _sharedPreferences.remove(_sharedPrefsKey);
            await _sharedPreferences.remove(_sharedPrefsNipKey);
            await _sharedPreferences.remove(_sharedPrefsPasswordKey);
          },
          signedUp: (value) {},
          error: (error) async {
            await _sharedPreferences.remove(_sharedPrefsKey);
            await _sharedPreferences.remove(_sharedPrefsNipKey);
            await _sharedPreferences.remove(_sharedPrefsPasswordKey);
          },
        );
      },
    );
  }

  Future<Auth> _loginRecoveryAttemp() async {
    try {
      state = const AsyncValue<Auth>.loading();
      final nip = _sharedPreferences.getString(_sharedPrefsNipKey);
      final password = _sharedPreferences.getString(_sharedPrefsPasswordKey);
      print("nip ${nip.toString()}");
      print("pw ${password.toString()}");

      if (nip == null || password == null) {
        throw Exception('No token found');
      }
      return _loginWithNipAndPassword(nip, password);
    } catch (e) {
      print(e);
      await _sharedPreferences.remove(_sharedPrefsKey);
      return const Auth.signedOut();
    }
  }

  Future<Auth> _loginWithNipAndPassword(String nip, String password) async {
    state = const AsyncValue<Auth>.loading();

    final loginAttemp = await AsyncValue.guard<Auth>(
      () async {
        try {
          final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.login);
          final Response response = await dio.post(
            uri.toString(),
            data: {
              'no_ktp': nip,
              'password': password,
            },
          );
          print("DISINI ${response.data}");
          final data = response.data;
          final token = data['data']['original']['access_token'];
          await _sharedPreferences.setString(_sharedPrefsKey, token);
          await _sharedPreferences.setString(_sharedPrefsNipKey, nip);
          await _sharedPreferences.setString(_sharedPrefsPasswordKey, password);
          // ignore: avoid_print
          final Auth auth = Auth.signedIn(
            nip: nip,
            password: password,
            token: token,
          );
          return auth;
        } on DioException catch (e) {
          print("DISANA ${e.response}");
          if (e.response?.statusCode == 500) {
            return const Auth.error("Internal Server Error");
          }
          print("ANJING ${e.response?.data['message']}");
          return Auth.error(e.response?.data['message'] ?? 'Error');
        } catch (e) {
          print("KAMPANG ${e.toString()}");
          return const Auth.error("Terjadi kesalahan");
        }
      },
    );

    print("HAHSAHASDASDDAS $loginAttemp");

    if (loginAttemp is AsyncData) {
      print("INI MASALAHA");
      final accessToken = _sharedPreferences.getString(_sharedPrefsKey);
      return Auth.signedIn(
        nip: nip,
        password: password,
        token: accessToken ?? '',
      );
    } else {
      await _sharedPreferences.remove(_sharedPrefsKey);
      return const Auth.signedOut();
    }
  }

  Future<Auth> _loginWithToken(String token) async {
    state = const AsyncValue<Auth>.loading();

    final loginAttemp = await AsyncValue.guard<Auth>(
      () async {
        try {
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
          // ignore: avoid_print
          final Auth auth = Auth.signedIn(
            token: accessToken,
          );
          return auth;
        } on DioException catch (e) {
          if (e.response!.statusCode! >= 500) {
            return const Auth.error("Internal Server Error");
          }
          return Auth.error(e.response?.data['message'] ?? 'Error');
        } catch (e) {
          return const Auth.error("Terjadi kesalahan");
        }
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
        try {
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
          await _sharedPreferences.setString(_sharedPrefsNipKey, nik);
          await _sharedPreferences.setString(_sharedPrefsPasswordKey, password);
          final Auth auth = Auth.signedIn(
            nip: nik,
            password: password,
            token: token,
          );
          return auth;
        } on DioException catch (e) {
          print("error ${e.toString()}");

          if (e.response!.statusCode! >= 500) {
            return const Auth.error("Internal Server Error");
          }
          return Auth.error(e.response?.data['message'] ?? 'Error');
        } catch (e) {
          return const Auth.error("Terjadi kesalahan");
        }
      },
    );
  }

  Future<void> logout() async {
    state = const AsyncValue<Auth>.loading();
    state = await AsyncValue.guard<Auth>(
      () async {
        try {
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
          await _sharedPreferences.remove(_sharedPrefsNipKey);
          await _sharedPreferences.remove(_sharedPrefsPasswordKey);
          const Auth auth = Auth.signedOut();
          return auth;
        } on DioException catch (e) {
          if (e.response!.statusCode! >= 500) {
            return const Auth.error("Internal Server Error");
          }
          return Auth.error(e.response?.data['message'] ?? 'Error');
        } catch (e) {
          return const Auth.error("Terjadi kesalahan");
        }
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
    state = await AsyncValue.guard<Auth>(
      () async {
        try {
          final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.register);
          await dio.post(
            uri.toString(),
            data: {
              'no_ktp': nik,
              'name': nama,
              'email': email,
              'password': password,
            },
          );
          const auth = Auth.signedUp();
          return auth;
        } on DioException catch (e) {
          if (e.response!.statusCode! >= 500) {
            return const Auth.error("Internal Server Error");
          }

          return Auth.error(e.response?.data['message'] ?? 'Error');
        } catch (e) {
          return const Auth.error("Terjadi kesalahan");
        }
      },
    );
  }
}
