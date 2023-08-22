import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/cards/carousel_pengajuan_card.dart';
import 'package:flutter_map_simtaru/components/custom_appbar_fitur.dart';
import 'package:flutter_map_simtaru/components/item_pengajuan.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class OverviewPengajuanPage extends StatelessWidget {
  const OverviewPengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppBarFitur(title: "Pengajuan"),
          Stack(
            children: [
              Container(
                color: AppColors.primaryColor,
                child: const SizedBox(
                  width: double.infinity,
                  height: 100,
                ),
              ),
              const CarouselPengajuanCard(),
            ],
          ),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              return const ItemPengajuan();
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
