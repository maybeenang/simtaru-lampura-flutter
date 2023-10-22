import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pengajuan_user_controller.g.dart';

@riverpod
class PengajuanUserController extends _$PengajuanUserController {
  final Dio dio = Dio();
  int page = 1;
  int userId = 0;

  @override
  FutureOr<List<Pengajuan>> build() async {
    page = 1;
    ref.listenSelf(
      (_, __) {
        if (state.isLoading) return;
      },
    );

    userId = ref.watch(userControllerProvider).maybeWhen(
          data: (data) {
            if (data is UserSuccess) {
              return data.model.id;
            } else {
              return 0;
            }
          },
          orElse: () => 0,
        );

    if (userId == 0) {
      return [];
    }

    try {
      String query = "$userId?page=$page";
      final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.userPengajuan + query);
      final Response response = await dio.get(
        uri.toString(),
      );

      final List<Pengajuan> pengajuan = (response.data['data'] as List).map((e) => Pengajuan.fromJson(e)).toList();

      return pengajuan;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<bool> loadMore() async {
    final loadMorePengajuan = await AsyncValue.guard<List<Pengajuan>>(
      () async {
        try {
          page++;
          String query = "$userId?page=$page";
          final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.userPengajuan + query);
          final Response response = await dio.get(
            uri.toString(),
          );
          final List<Pengajuan> pengajuan = (response.data['data'] as List).map((e) => Pengajuan.fromJson(e)).toList();

          return pengajuan;
        } catch (e) {
          return Future.error(e.toString());
        }
      },
    );

    return loadMorePengajuan.maybeWhen(orElse: () {
      page--;
      return true;
    }, data: (value) {
      if (value.isEmpty) {
        page--;
        return true;
      }
      state = AsyncValue.data([...state.value!, ...value]);
      return false;
    });
  }

  FutureOr<List<Pengajuan>> getPengajuan() async {
    page = 1;
    ref.listenSelf(
      (_, __) {
        if (state.isLoading) return;
      },
    );

    userId = ref.watch(userControllerProvider).maybeWhen(
          data: (data) {
            if (data is UserSuccess) {
              return data.model.id;
            } else {
              return 0;
            }
          },
          orElse: () => 0,
        );

    if (userId == 0) {
      return [];
    }

    try {
      String query = "$userId?page=$page";
      final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.userPengajuan + query);
      final Response response = await dio.get(
        uri.toString(),
      );

      final List<Pengajuan> pengajuan = (response.data['data'] as List).map((e) => Pengajuan.fromJson(e)).toList();

      return pengajuan;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
