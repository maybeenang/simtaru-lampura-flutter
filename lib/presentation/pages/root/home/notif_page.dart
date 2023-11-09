import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/controllers/notif_controller.dart/notif_controller.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:flutter_map_simtaru/presentation/widgets/items/notif_item.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotifPage extends HookConsumerWidget {
  const NotifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifState = ref.watch(notifControllerProvider);

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
                notifState.maybeWhen(
                  orElse: () {
                    return const Text(
                      "Tidak ada notifikasi",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 14,
                      ),
                    );
                  },
                  loading: () {
                    return const Text(
                      "Loading...",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 14,
                      ),
                    );
                  },
                  data: (data) {
                    if (data!.isEmpty) {
                      return const Text(
                        "Tidak ada notifikasi",
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14,
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return NotifItem(
                          notif: data[index],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
