import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_controller.g.dart';

@riverpod
FutureOr<Map<String, dynamic>> weather(WeatherRef ref) async {
  final Dio dio = Dio();

  try {
    final response = await dio.get(Endpoints.weatherEndpoint);

    return response.data;
  } catch (e) {
    print(e);

    return {};
  }
}
