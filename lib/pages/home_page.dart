import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/button_call_toaction.dart';
import 'package:flutter_map_simtaru/components/cards/carousel_berita_card.dart';
import 'package:flutter_map_simtaru/components/cards/carousel_welcome_card.dart';
import 'package:flutter_map_simtaru/components/cards/status_card.dart';
import 'package:flutter_map_simtaru/components/custom_appbar_fitur.dart';
import 'package:flutter_map_simtaru/components/custom_bar_chart.dart';
import 'package:flutter_map_simtaru/components/custom_line_chart.dart';
import 'package:flutter_map_simtaru/components/subheader.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.bgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomAppBarFitur(
              title: "Dashboard",
              bgColor: AppColors.primaryColor,
              labelColor: AppColors.whiteColor,
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
            const SubHeader(labelText: "Overview"),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  StatusCard(label: "Total Pengajuan"),
                  StatusCard(label: "Pengajuan Disetujui"),
                  StatusCard(label: "Pengajuan Diproses"),
                  StatusCard(label: "Pengajuan Ditolak"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const CustomBarChart(),
            const SizedBox(height: 10),
            const CustomLineChart(),
            const SizedBox(height: 20),
            const SubHeader(labelText: "Berita"),
            const SizedBox(height: 10),
            const CarouselBerita(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
