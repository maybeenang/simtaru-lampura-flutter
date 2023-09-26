import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/controllers/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pengajuan_controller.g.dart';

@riverpod
class PengajuanController extends _$PengajuanController {
  bool isAuth = false;
  final Dio dio = Dio();
  int page = 1;

  @override
  FutureOr<List<Pengajuan>?> build() async {
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
        final Uri uri =
            Uri.parse(Endpoints.baseURL + Endpoints.seluruhPengajuan + query);
        final Response response = await dio.get(
          uri.toString(),
        );

        final List<Pengajuan> pengajuan =
            (response.data['data']['data'] as List)
                .map((e) => Pengajuan.fromJson(e))
                .toList();

        return pengajuan;
      } catch (e) {
        return Future.error(e.toString());
      }
    } else {
      return null;
    }
  }

  Future<void> loadMore() async {
    final loadMorePengajuan = await AsyncValue.guard<List<Pengajuan>>(
      () async {
        try {
          page++;
          String query = "?page=$page";

          final Uri uri =
              Uri.parse(Endpoints.baseURL + Endpoints.seluruhPengajuan + query);
          final Response response = await dio.get(
            uri.toString(),
          );
          final List<Pengajuan> pengajuan =
              (response.data['data']['data'] as List)
                  .map((e) => Pengajuan.fromJson(e))
                  .toList();

          return pengajuan;
        } catch (e) {
          return Future.error(e.toString());
        }
      },
    );

    loadMorePengajuan.whenData((value) {
      state = AsyncValue.data([...state.value!, ...value]);
    });
  }
}
