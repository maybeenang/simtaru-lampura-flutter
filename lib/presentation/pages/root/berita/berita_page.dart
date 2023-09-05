import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/berita_item_card.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_appbar_fitur.dart';

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
            bgColor: AppColors.primaryColor,
            labelColor: AppColors.whiteColor,
          ),
          const SizedBox(height: 20),
          ListView.separated(
            itemBuilder: (context, index) {
              return const BeritaItemCard();
            },
            separatorBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 20,
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
