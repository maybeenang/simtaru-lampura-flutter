import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pengajuan_ditolak_controller.g.dart';

@riverpod
class PengajuanDitolakController extends _$PengajuanDitolakController {
  final Dio dio = Dio();
  int page = 1;

  @override
  FutureOr<List<Pengajuan>> build() async {
    ref.listenSelf(
      (_, __) {
        if (state.isLoading) return;
      },
    );

    try {
      String query = "?page=$page";
      final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.pengajuanByStatus + 1.toString() + query);
      final Response response = await dio.get(
        uri.toString(),
      );

      final List<Pengajuan> pengajuan =
          (response.data['data']['data'] as List).map((e) => Pengajuan.fromJson(e)).toList();

      return pengajuan;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> loadMore() async {
    final loadMorePengajuan = await AsyncValue.guard<List<Pengajuan>>(
      () async {
        try {
          page++;
          String query = "?page=$page";

          final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.pengajuanByStatus + 1.toString() + query);
          final Response response = await dio.get(
            uri.toString(),
          );
          final List<Pengajuan> pengajuan =
              (response.data['data']['data'] as List).map((e) => Pengajuan.fromJson(e)).toList();

          return pengajuan;
        } catch (e) {
          return Future.error(e.toString());
        }
      },
    );

    loadMorePengajuan.whenData((value) {
      if (value.isEmpty) {
        page--;
      }

      state = AsyncValue.data([...state.value!, ...value]);
    });
  }
}
