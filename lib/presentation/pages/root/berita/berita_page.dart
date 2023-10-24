import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/presentation/controllers/artikel/artikel_controller.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/berita_item_card.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/loading/item_artikel_loading.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_appbar_fitur.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BeritaPage extends HookConsumerWidget {
  const BeritaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artikelState = ref.watch(artikelControllerProvider);

    return Container(
      color: AppColors.bgColor,
      child: ListView(
        children: [
          const CustomAppBarFitur(
            title: "Artikel",
            bgColor: AppColors.primaryColor,
            labelColor: AppColors.whiteColor,
          ),
          const SizedBox(height: 20),
          artikelState.when(
            data: (data) {
              if (data!.isEmpty) {
                return const Center(
                  child: Text("Tidak ada artikel"),
                );
              }

              return ListView.separated(
                itemBuilder: (context, index) {
                  return BeritaItemCard(
                    artikel: data[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 20,
                  );
                },
                itemCount: data.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              );
            },
            error: (error, stackTrace) {
              return const Center(child: Text("Terjadi kesalahan"));
            },
            loading: () {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return const ItemArtikelLoading();
                },
                separatorBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 20,
                  );
                },
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              );
            },
          ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}
