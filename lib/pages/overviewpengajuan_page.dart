import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/cards/carousel_pengajuan_card.dart';
import 'package:flutter_map_simtaru/components/custom_appbar_fitur.dart';
import 'package:flutter_map_simtaru/components/item_pengajuan.dart';
import 'package:flutter_map_simtaru/components/textfield_common.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const TextFiledCommon(labelText: "Cari Pengajuan"),
                  ),
                  Material(
                    child: InkWell(
                      onTap: () {},
                      child: Ink(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
      ),
    );
  }
}
