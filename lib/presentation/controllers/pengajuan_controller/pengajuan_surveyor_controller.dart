import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/catatan_pengajuan.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/controllers/dio/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pengajuan_surveyor_controller.g.dart';

@riverpod
class PengajuanSurveyorController extends _$PengajuanSurveyorController {
  int page = 1;
  int pageSelesai = 1;
  bool isLoadMoreUpload = false;
  bool isLoadMoreSelesai = false;

  @override
  FutureOr<List<Pengajuan>> build() async {
    final Dio dio = ref.watch(dioProvider);
    page = 1;
    pageSelesai = 1;
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

      List<Pengajuan> pengajuan = (response.data['data'] as List).map((e) => Pengajuan.fromJson(e)).toList();

      return pengajuan;
    } catch (e) {
      return [];
    }
  }

  Future<bool> loadMore() async {
    print("KONTOOOOOOOOOL ${isLoadMoreUpload} ${isLoadMoreSelesai}");

    if (!isLoadMoreUpload) {
      final res = await loadMoreUpload();
      return res;
    } else {
      final res = await loadMoreSelesai();
      print("MEMEK ${res} ");
      return res;
    }
  }

  Future<bool> loadMoreUpload() async {
    final Dio dio = ref.watch(dioProvider);
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
          return [];
        }
      },
    );

    return loadMorePengajuan.maybeWhen(orElse: () {
      page--;
      isLoadMoreUpload = true;
      return true;
    }, data: (value) {
      if (value.isEmpty) {
        page--;
        isLoadMoreUpload = true;
        return true;
      }
      state = AsyncValue.data([...state.value!, ...value]);
      return false;
    });
  }

  Future<bool> loadMoreSelesai() async {
    print("MEMEK ${pageSelesai}");
    final Dio dio = ref.watch(dioProvider);
    final loadMorePengajuan = await AsyncValue.guard<List<Pengajuan>>(
      () async {
        try {
          // page++;
          String query = "?page=$pageSelesai";

          final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.pengajuanByStatus + 12.toString() + query);
          final Response response = await dio.get(
            uri.toString(),
          );
          final List<Pengajuan> pengajuan = (response.data['data'] as List).map((e) => Pengajuan.fromJson(e)).toList();

          return pengajuan;
        } catch (e) {
          return [];
        }
      },
    );

    return loadMorePengajuan.maybeWhen(orElse: () {
      return true;
    }, data: (value) {
      if (value.isEmpty) {
        return true;
      }
      pageSelesai++;
      state = AsyncValue.data([...state.value!, ...value]);
      return false;
    });
  }

  FutureOr<List<Pengajuan>> getPengajuan() async {
    final Dio dio = ref.watch(dioProvider);
    isLoadMoreUpload = false;
    isLoadMoreSelesai = false;
    page = 1;
    pageSelesai = 1;
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
      return [];
    }
  }

  Future<bool> tambahCatatanPengajuan(String id, String catatan) async {
    final Dio dio = ref.watch(dioProvider);
    try {
      final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.createCatatanPengajuan);
      await dio.post(
        uri.toString(),
        data: {
          'pengajuan_id': id,
          'keterangan': catatan,
        },
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<CatatanPengajuan>> getCatatanPengajuan(String id) async {
    final Dio dio = ref.watch(dioProvider);
    try {
      final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.getCatatanPengajuan + id);
      final Response response = await dio.get(
        uri.toString(),
      );

      final List<CatatanPengajuan> catatanPengajuan =
          (response.data['data'] as List).map((e) => CatatanPengajuan.fromJson(e)).toList();

      return catatanPengajuan;
    } catch (e) {
      return [];
    }
  }
}
