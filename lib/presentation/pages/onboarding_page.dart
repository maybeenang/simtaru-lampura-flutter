import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/data/constants/image.dart';
import 'package:flutter_map_simtaru/domain/entity/onboard.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) {
    const LoginRoute().go(context);
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
      imagePadding: EdgeInsets.all(30),
      imageFlex: 2,
      bodyFlex: 1,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: const BoxDecoration(
            color: AppColors.bgColor,
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const SizedBox(
            width: 100,
            child: Image(
              image: AssetImage(Images.logo),
            ),
          ),
        ),
        Expanded(
          child: IntroductionScreen(
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
            dotsContainerDecorator: ShapeDecoration(
              color: AppColors.whiteColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    AppDouble.borderRadius,
                  ),
                ),
              ),
              shadows: [
                AppStyles.boxShadowStyle,
              ],
            ),
            onDone: () => _onIntroEnd(context),
            onSkip: () => _onIntroEnd(context),
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
          ),
        ),
      ],
    );
  }
}
