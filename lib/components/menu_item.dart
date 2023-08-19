import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:go_router/go_router.dart';

class MenuItem extends StatelessWidget {
  MenuItem({super.key, required this.label, required this.icon});

  final String label;
  final String icon;

  final Map<String, IconData> iconMapping = {
    "Pengajuan": Icons.note_add,
    "Peta": Icons.location_on,
    "Informasi": Icons.info,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/${label.toLowerCase()}');
      },
      child: Card(
        color: AppColors.whiteColor,
        child: Container(
          padding: const EdgeInsets.all(5),
          width: 100,
          height: 100,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(iconMapping[icon]),
                Text(label, textAlign: TextAlign.center),
              ]),
        ),
      ),
    );
  }
}
