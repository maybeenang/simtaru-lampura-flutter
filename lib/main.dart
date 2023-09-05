import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/image.dart';
import 'package:flutter_map_simtaru/presentation/pages/login_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/onboarding_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/register_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/berita/detail_berita_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/berita/detail_pengajuan_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/home/notif_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/pengajuan/pengajuan_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/pengajuan/search_pengajuan_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/profile/edit_profile_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/root_page.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

final GoRouter _route = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const RootWidget(),
      routes: [
        GoRoute(
          path: 'pengajuan',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const PengajuanPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(
                  CurveTween(curve: curve),
                );

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: 'search_pengajuan',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const SearchPengajuanPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: 'detail_pengajuan',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const DetailPengajuanPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(
                  CurveTween(curve: curve),
                );

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: 'detail_berita',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const DetailBeritaPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(
                  CurveTween(curve: curve),
                );

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: 'edit_profile',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const EditProfilePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(
                  CurveTween(curve: curve),
                );

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: 'notif',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const NotifPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(
                  CurveTween(curve: curve),
                );

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const LoginPage(),
          fullscreenDialog: true,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const RegisterPage(),
          fullscreenDialog: true,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/on_boarding',
      builder: (context, state) => const OnBoardingPage(),
    )
  ],
  initialLocation: '/on_boarding',
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage(Images.bgPeta), context);
    precacheImage(const AssetImage(Images.logo), context);
    return MaterialApp.router(
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        elevatedButtonTheme: AppStyles.elevatedButtonThemeData,
        scaffoldBackgroundColor: AppColors.bgColor,
        appBarTheme: AppStyles.appBarTheme,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _route,
    );
  }
}
