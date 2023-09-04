import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class NotifBadge extends StatelessWidget {
  const NotifBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
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
    );
  }
}
