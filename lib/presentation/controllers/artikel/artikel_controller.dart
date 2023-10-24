import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/domain/entity/artikel/artikel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'artikel_controller.g.dart';

@riverpod
class ArtikelController extends _$ArtikelController {
  final Dio dio = Dio();
  int page = 1;

  @override
  FutureOr<List<Artikel>?> build() async {
    page = 1;
    ref.listenSelf(
      (_, __) {
        // One could write more conditional logic for when to call redirection
        if (state.isLoading) return;
      },
    );

    final artikel = await getAllArtikel();
    if (artikel is List<Artikel>) {
      return artikel;
    } else {
      return Future.error("Terjadi Kesalahan");
    }
  }

  FutureOr<List<Artikel>?> getAllArtikel() async {
    page = 1;

    try {
      final query = "?page=$page";
      final url = Endpoints.baseURL + Endpoints.getAllArtikel + query;
      final response = await dio.get(url);
      final data = response.data['data']['data'];
      final List<Artikel> artikel = (data as List)
          .map(
            (e) => Artikel.fromJson(e),
          )
          .toList();
      return artikel;
    } catch (e) {
      print("INI SALAH NGAB ${e.toString()}");
      return Future.error(e.toString());
    }
  }

  Future<String> createArtikel(data) async {
    try {
      final url = Endpoints.baseURL + Endpoints.createArtikel;
      await dio.post(url, data: data);
      ref.invalidate(artikelControllerProvider);
      return "Berhasil Tambah Artikel";
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
