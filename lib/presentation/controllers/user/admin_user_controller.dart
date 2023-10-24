import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_user_controller.g.dart';

@riverpod
class AdminUserController extends _$AdminUserController {
  final Dio dio = Dio();
  int page = 1;

  @override
  FutureOr<List<User>?> build() async {
    page = 1;
    ref.listenSelf(
      (_, __) {
        // One could write more conditional logic for when to call redirection
        if (state.isLoading) return;
      },
    );

    final user = await getAllUser();
    if (user is List<User>) {
      return user;
    } else {
      return Future.error("Terjadi Kesalahan");
    }
  }

  FutureOr<List<User>?> getAllUser() async {
    page = 1;
    try {
      final query = "?page=$page";
      final url = Endpoints.baseURL + Endpoints.getAllUser + query;
      final response = await dio.get(url);
      final data = response.data['data']['data'];
      final List<User> users = (data as List)
          .map(
            (e) => User.success(
              UserUtils.fromJson(e),
            ),
          )
          .toList();
      return users;
    } catch (e) {
      print("INI SALAH NGAB ${e.toString()}");
      return Future.error(e.toString());
    }
  }

  Future<bool> loadMore() async {
    final loadMorePengajuan = await AsyncValue.guard<List<User>>(
      () async {
        try {
          page++;
          String query = "?page=$page";

          final url = Endpoints.baseURL + Endpoints.getAllUser + query;
          final Response response = await dio.get(
            url,
          );

          final data = response.data['data']['data'];
          final List<User> users = (data as List)
              .map(
                (e) => User.success(
                  UserUtils.fromJson(e),
                ),
              )
              .toList();

          return users;
        } catch (e) {
          return Future.error(e.toString());
        }
      },
    );

    return loadMorePengajuan.maybeWhen(
      orElse: () {
        page--;
        return true;
      },
      data: (value) {
        if (value.isEmpty) {
          page--;
          return true;
        }
        state = AsyncValue.data([...state.value!, ...value]);
        return false;
      },
    );
  }

  FutureOr<List<User>?> getUser() async {
    page = 1;
    ref.listenSelf(
      (_, __) {
        // One could write more conditional logic for when to call redirection
        if (state.isLoading) return;
      },
    );

    final user = await getAllUser();
    if (user is List<User>) {
      return user;
    } else {
      return Future.error("Terjadi Kesalahan");
    }
  }

  FutureOr<User> createUser(Map data) async {
    try {
      final url = Endpoints.baseURL + Endpoints.tambahUser;
      final response = await dio.post(
        url,
        data: data,
      );

      final dataResponse = response.data['data'];
      dataResponse['is_active'] = 1;

      final User user = User.success(
        UserUtils.fromJson(dataResponse),
      );

      ref.invalidate(adminUserControllerProvider);

      return user;
    } on DioException catch (e) {
      if (e.response != null) {
        var dataResponse = e.response!.data['message'] ?? "Terjadi Kesalahan";

        final User user = User.error(
          dataResponse.toString(),
        );

        return user;
      } else {
        const User user = User.error(
          "Internal Server Error",
        );
        return user;
      }
    } catch (e) {
      print("INI SALAH NGABB ${e.toString()}");
      const User user = User.error(
        "Terjadi Kesalahan",
      );
      return user;
    }
  }

  Future<User> editUser(Map data, String id) async {
    print(data.toString());
    try {
      final url = Endpoints.baseURL + Endpoints.editUser + id;
      final response = await dio.post(
        url,
        data: data,
      );
      var dataResponse = response.data['data'];

      final User user = User.success(
        UserUtils.fromJson(dataResponse),
      );

      ref.invalidate(adminUserControllerProvider);
      return user;
    } on DioException catch (e) {
      print("INI SALAH ${e.toString()}");

      if (e.response != null) {
        final dataResponse = e.response!.data['message'] ?? "Terjadi Kesalahan";
        final User user = User.error(
          dataResponse.toString(),
        );
        return user;
      } else {
        const User user = User.error(
          "Internal Server Error",
        );
        return user;
      }
    } catch (e, s) {
      print("INI SALAH NGABB ${e.toString()}");
      print("INI NGABB ${s.toString()}");
      const User user = User.error(
        "Terjadi Kesalahan",
      );
      return user;
    }
  }

  Future<User> deleteUser(String id) async {
    try {
      final url = Endpoints.baseURL + Endpoints.hapusUser + id;

      final Response response = await dio.post(url);

      final dataResponse = response.data['data'];

      final User user = User.success(
        UserUtils.fromJson(dataResponse),
      );

      await ref.refresh(adminUserControllerProvider.notifier).getUser();

      return user;
    } catch (e) {
      print("INI SALAH NGABB ${e.toString()}");
      const User user = User.error(
        "Terjadi Kesalahan",
      );
      return user;
    }
  }
}
