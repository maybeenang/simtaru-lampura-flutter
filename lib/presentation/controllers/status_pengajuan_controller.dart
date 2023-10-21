import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/status_pengajuan.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'status_pengajuan_controller.g.dart';

@riverpod
class StatusPengajuanController extends _$StatusPengajuanController {
  final Dio dio = Dio();

  @override
  Future<List<StatusPengajuan>> build() async {
    try {
      final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.statusPengajuan);
      final Response response = await dio.get(
        uri.toString(),
      );

      final data = response.data;

      final List<StatusPengajuan> statusPengajuan = List<StatusPengajuan>.from(
        data['data'].map(
          (json) => StatusPengajuan.fromJson(json),
        ),
      );

      return statusPengajuan;
    } catch (e) {
      print("STATYS  $e");
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
}
