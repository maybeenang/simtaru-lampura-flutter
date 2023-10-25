import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/presentation/controllers/sharedpreferences/sharedpreferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final SharedPreferences sharedPreferences = ref.watch(sharedPreferenceProvider).asData!.value;
  const sharedPrefsKey = 'token';

  final token = sharedPreferences.getString(sharedPrefsKey);

  final dioPrivate = Dio();
  dioPrivate.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
    ),
  );

  return dioPrivate;
}
