import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/controllers/index_screen_provider.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/root_page.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_call_toaction.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/carousel_berita_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/carousel_welcome_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/home_profile_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/status_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/notif_badge.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_bar_chart.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_line_chart.dart';
import 'package:flutter_map_simtaru/presentation/widgets/other/subheader.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.bgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: AppColors.primaryColor,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: const Image(image: AssetImage("assets/images/logo.png"), width: 75, height: 75),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const NotifBadge(),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const HomeProfileCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  color: AppColors.primaryColor,
                  child: const SizedBox(
                    width: double.infinity,
                    height: 100,
                  ),
                ),
                const CaroueselWelcomeCard(),
              ],
            ),
            const SizedBox(height: 20),
            const ButtonCallToAction(),
            const SizedBox(height: 30),
            const SubHeader(labelText: "Informasi Umum"),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDouble.paddingOutside),
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(AppDouble.borderRadius),
                  boxShadow: [AppStyles.boxShadowStyle],
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Pengajuan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      runAlignment: WrapAlignment.spaceBetween,
                      children: [
                        StatusCard(label: "Total Pengajuan"),
                        StatusCard(label: "Pengajuan Disetujui"),
                        StatusCard(label: "Pengajuan Diproses"),
                        StatusCard(label: "Pengajuan Ditolak"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const CustomBarChart(),
            const SizedBox(height: 10),
            const CustomLineChart(),
            const SizedBox(height: 30),
            SubHeader(
              labelText: "Artikel",
              showAction: true,
              onTap: () {
                ref.read(indexScreenProvider.notifier).onIndexChange(3);
                ref.read(controllerNavbarProvider).index = 3;
              },
            ),
            const SizedBox(height: 10),
            const CarouselBerita(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
