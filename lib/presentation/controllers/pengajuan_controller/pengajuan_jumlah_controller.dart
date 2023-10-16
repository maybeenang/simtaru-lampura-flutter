import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/jumlah_pengajuan.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pengajuan_jumlah_controller.g.dart';

@riverpod
class PengajuanJumlahController extends _$PengajuanJumlahController {
  final Dio dio = Dio();

  @override
  FutureOr<JumlahPengajuan> build() async {
    ref.listenSelf(
      (_, __) {
        if (state.isLoading) return;
      },
    );

    try {
      final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.pengajuanJumlah);
      final Response response = await dio.get(
        uri.toString(),
      );

      final JumlahPengajuan jumlahPengajuan = JumlahPengajuan.fromJson(response.data);

      return jumlahPengajuan;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
