import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/presentation/controllers/dio/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_controller.g.dart';

@riverpod
FutureOr<Map<String, dynamic>> weather(WeatherRef ref) {
  final Dio dio = ref.watch(dioProvider);
  return dio.get(Endpoints.weatherEndpoint).then((value) => value.data);
}
