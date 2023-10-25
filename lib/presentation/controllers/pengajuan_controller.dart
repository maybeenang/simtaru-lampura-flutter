import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/controllers/auth_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/dio/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pengajuan_controller.g.dart';

@riverpod
class PengajuanController extends _$PengajuanController {
  bool isAuth = false;
  int page = 1;

  @override
  FutureOr<List<Pengajuan>?> build() async {
    final Dio dio = ref.watch(dioProvider);

    page = 1;
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
        if (state.isLoading) return;
      },
    );

    if (isAuth) {
      try {
        String query = "?page=$page";
        final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.seluruhPengajuan + query);
        final Response response = await dio.get(
          uri.toString(),
        );

        final List<Pengajuan> pengajuan = (response.data['data'] as List).map((e) => Pengajuan.fromJson(e)).toList();

        return pengajuan;
      } catch (e) {
        return Future.error(e.toString());
      }
    } else {
      return null;
    }
  }

  Future<bool> loadMore() async {
    final Dio dio = ref.watch(dioProvider);

    final loadMorePengajuan = await AsyncValue.guard<List<Pengajuan>>(
      () async {
        try {
          page++;
          String query = "?page=$page";

          final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.seluruhPengajuan + query);
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

  FutureOr<List<Pengajuan>?> getPengajuan() async {
    final Dio dio = ref.watch(dioProvider);

    page = 1;
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
        if (state.isLoading) return;
      },
    );

    if (isAuth) {
      try {
        String query = "?page=$page";
        final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.seluruhPengajuan + query);
        final Response response = await dio.get(
          uri.toString(),
        );

        final List<Pengajuan> pengajuan = (response.data['data'] as List).map((e) => Pengajuan.fromJson(e)).toList();
        state = AsyncValue.data(pengajuan);
        return pengajuan;
      } catch (e) {
        print("DINISADNASIDANSD $e");
        return Future.error(e.toString());
      }
    } else {
      return null;
    }
  }
}
