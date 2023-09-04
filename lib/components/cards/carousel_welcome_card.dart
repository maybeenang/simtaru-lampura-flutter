import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/cards/welcome_card.dart';

class CaroueselWelcomeCard extends StatefulWidget {
  const CaroueselWelcomeCard({super.key});

  @override
  State<CaroueselWelcomeCard> createState() => _CaroueselWelcomeCardState();
}

class _CaroueselWelcomeCardState extends State<CaroueselWelcomeCard> {
  final CarouselController buttonCarouselController = CarouselController();

  late int _currentCarousel;

  final List<Widget> _welcomeCards = const [
    WelcomeCard(),
    WelcomeCard(),
    WelcomeCard(),
    WelcomeCard(),
  ];

  @override
  void initState() {
    super.initState();
    _currentCarousel = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: _welcomeCards,
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            height: 200,
            viewportFraction: 0.94,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(
                () {
                  _currentCarousel = index;
                },
              );
            },
          ),
        ),
        DotsIndicator(
            dotsCount: _welcomeCards.length,
            position: _currentCarousel.toDouble()),
      ],
    );
  }
}
