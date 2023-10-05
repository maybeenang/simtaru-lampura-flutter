import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';

class ButtonProfile extends StatelessWidget {
  const ButtonProfile(
      {super.key,
      this.label = "Button",
      this.icon = Icons.add,
      this.onTap,
      this.color = AppColors.blackColor,
      this.notif = 0,
      this.isNotif = false});

  final String label;
  final IconData? icon;
  final Function()? onTap;
  final Color? color;
  final int? notif;
  final bool? isNotif;

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
              const Spacer(),
              if (isNotif!)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.redColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    notif.toString(),
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
