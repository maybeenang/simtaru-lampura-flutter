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
          backgroundColor: AppColors.secondaryColor,
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
            color: AppColors.secondaryColor,
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
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                StatusCard(),
                StatusCard(),
                StatusCard(),
              ],
            ),
          ),
          Wrap(
            children: [
              MenuItem(
                label: "Pengajuan",
                icon: "Pengajuan",
              ),
              MenuItem(
                label: "Peta",
                icon: "Pengajuan",
              ),
              MenuItem(
                label: "Informasi",
                icon: "Pengajuan",
              ),
            ],
          )
        ]));
  }
}
