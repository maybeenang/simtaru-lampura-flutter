import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/double.dart';

class CustomAppBarFitur extends StatelessWidget {
  const CustomAppBarFitur(
      {super.key,
      required this.title,
      required this.bgColor,
      required this.labelColor});

  final String title;
  final Color bgColor;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      padding: const EdgeInsets.all(AppDouble.paddingInside),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: labelColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
