import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/presentation/controllers/artikel/artikel_controller.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/berita_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CarouselBerita extends HookConsumerWidget {
  const CarouselBerita({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CarouselController buttonCarouselController = CarouselController();

    final artikelState = ref.watch(artikelControllerProvider);

    return artikelState.when(
      data: (data) {
        if (data!.isEmpty) {
          return const Center(
            child: Text("Tidak ada artikel"),
          );
        }

        return CarouselSlider.builder(
          itemCount: data.length,
          itemBuilder: (context, index, realIndex) {
            return BeritaCard(
              artikel: data[index],
            );
          },
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            viewportFraction: 0.95,
            enableInfiniteScroll: false,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
      error: (error, stackTrace) {
        return const Center(
          child: Text("Terjadi kesalahan"),
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
