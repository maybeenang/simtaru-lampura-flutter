import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/status_pengajuan_card.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class CarouselPengajuanCard extends StatefulWidget {
  const CarouselPengajuanCard({super.key});

  @override
  State<CarouselPengajuanCard> createState() => _CarouselPengajuanCardState();
}

class _CarouselPengajuanCardState extends State<CarouselPengajuanCard> {
  final CarouselController buttonCarouselController = CarouselController();

  int _currentCarousel = 0;

  final List<Widget> welcomeCards = [
    StatusPengajuanCard(label: "Total Pengajuan"),
    StatusPengajuanCard(label: "Pengajuan Disetujui"),
    StatusPengajuanCard(label: "Pengajuan Diproses"),
    StatusPengajuanCard(label: "Pengajuan Ditolak"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: welcomeCards,
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            height: 150,
            viewportFraction: 0.85,
            enableInfiniteScroll: false,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(
                () {
                  _currentCarousel = index;
                },
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: welcomeCards.map(
            (e) {
              final int index = welcomeCards.indexOf(e);
              return Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentCarousel == index
                      ? AppColors.primaryColor
                      : AppColors.greyColor,
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
