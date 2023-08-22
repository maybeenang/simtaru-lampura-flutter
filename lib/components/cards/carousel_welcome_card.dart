import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/welcome_card.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class CaroueselWelcomeCard extends StatefulWidget {
  const CaroueselWelcomeCard({super.key});

  @override
  State<CaroueselWelcomeCard> createState() => _CaroueselWelcomeCardState();
}

class _CaroueselWelcomeCardState extends State<CaroueselWelcomeCard> {
  final CarouselController buttonCarouselController = CarouselController();

  int _currentCarousel = 0;

  final List<Widget> welcomeCards = const [
    WelcomeCard(),
    WelcomeCard(),
    WelcomeCard(),
    WelcomeCard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: welcomeCards,
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            height: 200,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
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
