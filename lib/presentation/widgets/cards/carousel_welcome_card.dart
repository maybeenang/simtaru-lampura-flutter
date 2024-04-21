import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/welcome_card.dart';
import 'package:flutter_map_simtaru/data/constants/image.dart';

class CaroueselWelcomeCard extends StatefulWidget {
  const CaroueselWelcomeCard({super.key});

  @override
  State<CaroueselWelcomeCard> createState() => _CaroueselWelcomeCardState();
}

class _CaroueselWelcomeCardState extends State<CaroueselWelcomeCard> {
  final CarouselController buttonCarouselController = CarouselController();

  late int _currentCarousel;

  final List<Widget> _welcomeCards = const [
    WelcomeCard(image: Images.welcome1),
    WelcomeCard(image: Images.welcome2),
  ];

  @override
  void initState() {
    super.initState();
    _currentCarousel = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 200,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDouble.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          CarouselSlider(
            items: _welcomeCards,
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              height: 200,
              viewportFraction: 1,
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
          Align(
            alignment: Alignment.bottomCenter,
            child: DotsIndicator(
              dotsCount: _welcomeCards.length,
              position: _currentCarousel.toDouble(),
              decorator: DotsDecorator(
                color: AppColors.actionColor,
                activeColor: Colors.blue,
                activeSize: const Size.square(12.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
