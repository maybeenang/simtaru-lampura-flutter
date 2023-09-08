import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';

class NotifBadge extends StatelessWidget {
  const NotifBadge({super.key});

  @override
  Widget build(BuildContext context) {
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
            badgeContent: const Text(
              "1",
              style: TextStyle(
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
