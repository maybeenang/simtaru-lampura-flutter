import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/carousel_welcome_card.dart';
import 'package:flutter_map_simtaru/components/custom_appbar.dart';
import 'package:flutter_map_simtaru/components/custom_safe_area.dart';
import 'package:flutter_map_simtaru/components/drawer.dart';
import 'package:flutter_map_simtaru/components/menu_item.dart';
import 'package:flutter_map_simtaru/components/status_card.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const DrawerApp(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBar(),
              Stack(
                children: [
                  Container(
                    color: AppColors.primaryColor,
                    child: Container(
                      width: double.infinity,
                      height: 100,
                    ),
                  ),
                  const CaroueselWelcomeCard(),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "Overview",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "Menu",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                children: [
                  MenuItem(
                    label: "Pengajuan",
                    icon: "Pengajuan",
                  ),
                  MenuItem(
                    label: "Peta",
                    icon: "Peta",
                  ),
                  MenuItem(
                    label: "Informasi",
                    icon: "Informasi",
                  ),
                ],
              ),
              const SizedBox(height: 200)
            ],
          ),
        ),
      ),
    );
  }
}
