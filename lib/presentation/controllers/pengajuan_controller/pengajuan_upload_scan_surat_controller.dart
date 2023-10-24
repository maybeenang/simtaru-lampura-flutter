import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pengajuan_upload_scan_surat_controller.g.dart';

@riverpod
class PengajuanUploadScanSuratController extends _$PengajuanUploadScanSuratController {
  final Dio dio = Dio();
  int page = 1;

  @override
  FutureOr<List<Pengajuan>> build() async {
    page = 1;
    ref.listenSelf(
      (_, __) {
        if (state.isLoading) return;
      },
    );

    try {
      String query = "?page=$page";
      final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.pengajuanByStatus + 11.toString() + query);
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
          String query = "?page=$page";

          final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.pengajuanByStatus + 11.toString() + query);
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

    try {
      String query = "?page=$page";
      final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.pengajuanByStatus + 11.toString() + query);
      final Response response = await dio.get(
        uri.toString(),
      );

      final List<Pengajuan> pengajuan = (response.data['data'] as List).map((e) => Pengajuan.fromJson(e)).toList();

      state = AsyncValue.data(pengajuan);

      return pengajuan;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
