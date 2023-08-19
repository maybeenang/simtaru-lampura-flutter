import 'package:flutter/material.dart';

class SubHeader extends StatelessWidget {
  const SubHeader({super.key, required this.labelText});

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        labelText,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
