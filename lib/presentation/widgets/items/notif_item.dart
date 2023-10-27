import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/notif/notif.dart';
import 'package:intl/intl.dart';

class NotifItem extends StatelessWidget {
  const NotifItem({super.key, required this.notif});

  final Notif notif;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              notif.judul,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            // get date and time from timestamp
            DateFormat('dd-MM-yyyy, HH:mm').format(notif.created_at),
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.greyColor,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              notif.keterangan,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
        ],
      ),
    );
  }
}
