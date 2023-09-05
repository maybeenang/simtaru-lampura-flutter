import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:flutter_map_simtaru/presentation/widgets/items/notif_item.dart';
import 'package:go_router/go_router.dart';

class NotifPage extends StatelessWidget {
  const NotifPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      color: AppColors.bgColor,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDouble.paddingOutside),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.blackColor,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      "Notifikasi",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const NotifItem(),
                const Divider(
                  color: AppColors.borderColor,
                ),
                const NotifItem(),
                const Divider(
                  color: AppColors.borderColor,
                ),
                const NotifItem(),
                const Divider(
                  color: AppColors.borderColor,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                const Text(
                  "Tidak ada notifikasi",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
