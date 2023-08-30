import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:flutter_map_simtaru/models/onboard.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:go_router/go_router.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) {
    context.go('/login');
  }

  final List<OnBoard> _dataOnboarding = [
    OnBoard(
      image: "assets/svg/onboard_1.svg",
      title: "Selamat Datang di Simtaru",
      description:
          "Simtaru membawa tata ruang ke ujung jari Anda. Temukan segala yang Anda butuhkan untuk mengelola wilayah dengan bijak.",
    ),
    OnBoard(
      image: "assets/svg/onboard_2.svg",
      title: "Pemetaan dan Informasi",
      description:
          "Temukan data geospasial terkini, peraturan tata ruang, dan informasi penting lainnya dengan mudah dan cepat.",
    ),
    OnBoard(
      image: "assets/svg/onboard_3.svg",
      title: "Rencanakan Masa Depan",
      description:
          "Dengan Simtaru, Anda bisa merencanakan masa depan yang berkelanjutan dan efisien untuk wilayah Anda.",
    ),
    OnBoard(
      image: "assets/svg/onboard_4.svg",
      title: "Mari Mulai!",
      description:
          "Waktunya untuk memulai perjalanan Anda dengan Simtaru. Kami siap membantu Anda, langkah demi langkah.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 14.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.all(20),
      imageFlex: 5,
      bodyFlex: 2,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: AppColors.bgColor,
      allowImplicitScrolling: true,
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      pages: _dataOnboarding.map(
        (e) {
          return PageViewModel(
            title: e.title,
            body: e.description,
            decoration: pageDecoration,
            image: SvgPicture.asset(e.image),
          );
        },
      ).toList(),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text(
        'Lewati',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
      ),
      done: const Text(
        'Mulai',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: AppColors.primaryColor,
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
    );
  }
}
