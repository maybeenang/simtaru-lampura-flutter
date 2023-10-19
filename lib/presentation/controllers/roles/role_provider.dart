import 'package:flutter_map_simtaru/domain/entity/role/role.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'role_provider.g.dart';

@riverpod
Role role(RoleRef ref) {
  final userState = ref.watch(userControllerProvider);

  return userState.maybeWhen(
    orElse: () => const Role.user(),
    data: (data) {
      if (data is UserSuccess) {
        if (data.model.roles!.isEmpty) {
          return const Role.user();
        }
        switch (data.model.roles!.first['id']) {
          case 6:
            return const Role.user();
          default:
            return const Role.admin();
        }
      } else {
        return const Role.user();
      }
    },
  );
}
