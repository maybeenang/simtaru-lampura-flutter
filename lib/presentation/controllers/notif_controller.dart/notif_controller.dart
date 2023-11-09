import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/domain/entity/notif/notif.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/presentation/controllers/dio/dio_provider.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notif_controller.g.dart';

@riverpod
class NotifController extends _$NotifController {
  @override
  FutureOr<List<Notif>?> build() async {
    final dio = ref.watch(dioProvider);

    final userId = ref.watch(userControllerProvider).maybeWhen(
          data: (data) {
            if (data is UserSuccess) {
              return data.model.id;
            } else {
              return 0;
            }
          },
          orElse: () => 0,
        );

    ref.listenSelf(
      (_, __) {
        if (state.isLoading) return;
      },
    );

    try {
      final Response response = await dio.get("${Endpoints.baseURL}${Endpoints.getAllNotif}$userId");
      final data = response.data['data']['data'];
      final List<Notif> notif = (data as List).map((e) => Notif.fromJson(e)).toList();
      return notif;
    } catch (e) {
      return [];
    }
  }
}
