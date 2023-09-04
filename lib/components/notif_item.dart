import 'package:flutter/material.dart';

class NotifItem extends StatelessWidget {
  const NotifItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              "Pengumuman",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            child: Text(
              "Lorem ipsum dolor sit amet, cons Lorem ipsum dolor sit amet, cons",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
