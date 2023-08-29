import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/cards/berita_item_card.dart';
import 'package:flutter_map_simtaru/components/custom_appbar_fitur.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgColor,
      child: ListView(
        children: [
          const CustomAppBarFitur(
            title: "Berita",
            bgColor: AppColors.bgColor,
            labelColor: AppColors.blackColor,
          ),
          const SizedBox(height: 10),
          ListView.separated(
            itemBuilder: (context, index) {
              return const BeritaItemCard();
            },
            separatorBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 20,
                child: const Divider(),
              );
            },
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}
