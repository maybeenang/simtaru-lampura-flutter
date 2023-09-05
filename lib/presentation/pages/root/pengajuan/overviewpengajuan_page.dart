import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_search_pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/carousel_pengajuan_card.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_appbar_fitur.dart';
import 'package:flutter_map_simtaru/presentation/widgets/items/item_pengajuan.dart';

class OverviewPengajuanPage extends StatelessWidget {
  const OverviewPengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.bgColor,
        width: double.infinity,
        child: Column(
          children: [
            const CustomAppBarFitur(
              title: "Pengajuan",
              bgColor: AppColors.primaryColor,
              labelColor: AppColors.whiteColor,
            ),
            Stack(
              children: [
                Container(
                  color: AppColors.primaryColor,
                  child: const SizedBox(
                    width: double.infinity,
                    height: 25,
                  ),
                ),
                const ButtonSearchPengajuan(),
              ],
            ),
            const SizedBox(height: 20),
            const CarouselPengajuanCard(),
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
      ),
    );
  }
}
