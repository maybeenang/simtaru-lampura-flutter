import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/presentation/controllers/sharedpreferences/sharedpreferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  const sharedPrefsKey = 'token';
  String? token;
  ref.watch(sharedPreferenceProvider).map(data: (data) {
    token = data.value.getString(sharedPrefsKey);
    return data.value;
  }, error: (error) {
    return null;
  }, loading: (loading) {
    return null;
  });

  print("TOKENNN $token");

  final dioPrivate = Dio();

  if (token == null) {
    return dioPrivate;
  }

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
