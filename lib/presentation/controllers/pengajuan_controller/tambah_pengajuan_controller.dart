import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/presentation/controllers/dio/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tambah_pengajuan_controller.g.dart';

@riverpod
Future<bool> tambahPengajuan(TambahPengajuanRef ref, {required FormData data}) async {
  final Dio dio = ref.watch(dioProvider);
  print(data.fields);

  try {
    return true;
  } catch (e) {
    return false;
  }
}
