import 'package:dio/dio.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/domain/entity/role/role_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'role_controller.g.dart';

@riverpod
class RoleController extends _$RoleController {
  final Dio dio = Dio();

  @override
  Future<List<RoleDto>> build() async {
    try {
      final uri = Endpoints.baseURL + Endpoints.getAllRole;
      final Response response = await dio.get(
        uri,
      );

      final data = response.data;

      final List<RoleDto> role = List<RoleDto>.from(
        data['data'].map(
          (json) => RoleDto.fromJson(json),
        ),
      );

      return role;
    } on DioException catch (_) {
      ref.invalidate(roleControllerProvider);
      rethrow;
    } catch (e) {
      return [];
    }
  }
}
