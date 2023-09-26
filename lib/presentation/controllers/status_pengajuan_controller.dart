import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/status_pengajuan.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'status_pengajuan_controller.g.dart';

@riverpod
Future<StatusPengajuan> getStatusPengajuan() async {
  final Dio dio = Dio();

  try {
    final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.statusPengajuan);
    final Response response = await dio.get(
      uri.toString(),
    );

    final StatusPengajuan statusPengajuan =
        StatusPengajuan.fromJson(response.data['data']);
    return statusPengajuan;
  } catch (e) {
    return Future.error(e.toString());
  }
}
