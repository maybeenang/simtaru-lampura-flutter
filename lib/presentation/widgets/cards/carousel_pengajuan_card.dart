// import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/status_pengajuan_card.dart';

class CarouselPengajuanCard extends StatefulWidget {
  const CarouselPengajuanCard({super.key});

  @override
  State<CarouselPengajuanCard> createState() => _CarouselPengajuanCardState();
}

class _CarouselPengajuanCardState extends State<CarouselPengajuanCard> {
  // final carousel.CarouselController buttonCarouselController = carousel.CarouselController();

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
          // carouselController: buttonCarouselController,
          options: CarouselOptions(
            height: 150,
            viewportFraction: 0.95,
            enableInfiniteScroll: false,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(
                () {},
              );
            },
          ),
        ),
      ],
    );
  }
}
