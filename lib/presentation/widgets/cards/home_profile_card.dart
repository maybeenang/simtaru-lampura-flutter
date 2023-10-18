import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/weather/weather_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeProfileCard extends HookConsumerWidget {
  const HomeProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userControllerProvider);
    final weatherState = ref.watch(weatherProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDouble.paddingOutside),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: RichText(
                maxLines: 2,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Selamat Datang,\n",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextSpan(
                      text: userState.when(
                        data: (data) {
                          if (data is UserSuccess) {
                            return data.model.name;
                          } else {
                            return null;
                          }
                        },
                        error: (error, stackTrace) {
                          return null;
                        },
                        loading: () {
                          return null;
                        },
                      ),
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const VerticalDivider(
              color: AppColors.whiteColor,
              thickness: 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Total Pengajuan\n",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextSpan(
                      text: "0",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const VerticalDivider(
              color: AppColors.whiteColor,
              thickness: 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Suhu\n",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextSpan(
                      text: weatherState.when(
                        data: (data) {
                          return "${data['current']['temp_c']}°C";
                        },
                        error: (error, stackTrace) {
                          return "0";
                        },
                        loading: () {
                          return "-";
                        },
                      ),
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
