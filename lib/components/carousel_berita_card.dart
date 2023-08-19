import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/berita_card.dart';

class CarouselBerita extends StatefulWidget {
  const CarouselBerita({super.key});

  @override
  State<CarouselBerita> createState() => _CarouselBeritaState();
}

class _CarouselBeritaState extends State<CarouselBerita> {
  final CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 4,
      itemBuilder: (context, index, realIndex) {
        return const BeritaCard();
      },
      carouselController: buttonCarouselController,
      options: CarouselOptions(
        height: 280,
        viewportFraction: 0.85,
        enableInfiniteScroll: false,
        scrollDirection: Axis.horizontal,
        padEnds: true,
      ),
    );
  }
}
