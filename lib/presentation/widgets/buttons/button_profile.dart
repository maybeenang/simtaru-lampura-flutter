import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';

class ButtonProfile extends StatelessWidget {
  const ButtonProfile(
      {super.key,
      this.label = "Button",
      this.icon = Icons.add,
      this.onTap,
      this.color = AppColors.blackColor});

  final String label;
  final IconData? icon;
  final Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Text(label, style: TextStyle(color: color)),
            ],
          ),
        ),
      ),
    );
  }
}
