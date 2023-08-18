import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/drawer.dart';
import 'package:flutter_map_simtaru/components/menu_item.dart';
import 'package:flutter_map_simtaru/components/status_card.dart';
import 'package:flutter_map_simtaru/components/welcome_card.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: const Text("Dashboard"),
          backgroundColor: AppColors.primaryColor,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          leadingWidth: 50,
          iconTheme: IconThemeData(color: AppColors.whiteColor),
        ),
        drawer: const DrawerApp(),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            color: AppColors.primaryColor,
            child: Container(
                width: double.infinity,
                height: 20,
                decoration: const BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(50, 50),
                  ),
                )),
          ),
          const SizedBox(height: 10),
          const WelcomeCard(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Divider(
              color: AppColors.greyColor,
            ),
          ),
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
          )
        ]));
  }
}
