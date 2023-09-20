import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/domain/entity/user.dart';
import 'package:flutter_map_simtaru/domain/entity/user_utils.dart';
import 'package:flutter_map_simtaru/presentation/controllers/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_controller.g.dart';

@riverpod
class UserController extends _$UserController {
  late SharedPreferences _sharedPreferences;
  static const _sharedPrefsKey = 'token';
  bool isAuth = false;
  final Dio dio = Dio();

  @override
  FutureOr<User?> build() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    isAuth = await ref.watch(
      authControllerProvider.selectAsync(
        (data) => data.map(
          signedIn: (value) => true,
          signedOut: (value) => true,
          signedUp: (value) => false,
          error: (value) => false,
        ),
      ),
    );
    ref.listenSelf(
      (_, __) {
        // One could write more conditional logic for when to call redirection
        if (state.isLoading) return;
      },
    );

    if (isAuth) {
      final user = await getProfile();

      if (user is UserSuccess) {
        return user;
      } else {
        return const AsyncValue<User>.error("Error", StackTrace.empty).when(
            data: (data) => data,
            error: (error, stackTrace) => const User.error("Terjadi Kesalahan"),
            loading: () => null);
      }
    } else {
      return const User.error("Terjadi kesalahan");
    }
  }

  Future<User?> getProfile() async {
    state = const AsyncValue<User?>.loading();
    final token = _sharedPreferences.getString(_sharedPrefsKey);
    if (token == null) {
      return const User.error("Terjadi kesalahan");
    }

    final userAttemp = await AsyncValue.guard<User?>(
      () async {
        try {
          final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.profile);
          final Response response = await dio.post(uri.toString(),
              options: Options(headers: {"Authorization": "Bearer $token"}));
          final data = response.data["data"];
          final User user = User.success(UserUtils.fromJson(data));
          return user;
          // ignore: unused_catch_clause
        } on DioException catch (e) {
          return const User.error("Terjadi kesalahan");
        } catch (e) {
          return const User.error("Terjadi kesalahan");
        }
      },
    );

    return userAttemp.when(
      data: (data) => data,
      loading: () => null,
      error: (error, stackTrace) => User.error(error.toString()),
    );
  }
}
