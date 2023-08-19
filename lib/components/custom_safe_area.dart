import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class CustomSafeArea extends StatelessWidget {
  CustomSafeArea(
      {super.key, required this.child, this.color = AppColors.primaryColor});

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: SafeArea(
        child: child,
      ),
    );
  }
}
