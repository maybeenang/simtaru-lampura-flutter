import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_map_simtaru/presentation/controllers/notif_controller.dart/notif_controller.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotifBadge extends HookConsumerWidget {
  const NotifBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifLength = ref.watch(notifControllerProvider).maybeWhen(
          orElse: () => 0,
          data: (data) {
            if (data!.isEmpty) {
              return 0;
            } else {
              return data.length;
            }
          },
        );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Future.delayed(
            const Duration(milliseconds: 300),
            () {
              const NotifRoute().go(context);
            },
          );
        },
        child: Ink(
          padding: const EdgeInsets.all(10),
          child: badges.Badge(
            position: badges.BadgePosition.topEnd(top: -5, end: 0),
            badgeContent: Text(
              notifLength.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
            child: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
