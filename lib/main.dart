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
import 'package:flutter_map_simtaru/presentation/widgets/animations/custom_transition_page.dart';
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
            return AppPageTransition.customTransitionPageSlidex(
              const PengajuanPage(),
            );
          },
        ),
        GoRoute(
          path: 'search_pengajuan',
          pageBuilder: (context, state) {
            return AppPageTransition.customTransitionPageFade(
              const SearchPengajuanPage(),
            );
          },
        ),
        GoRoute(
          path: 'detail_pengajuan',
          pageBuilder: (context, state) {
            return AppPageTransition.customTransitionPageSlidex(
              const DetailPengajuanPage(),
            );
          },
        ),
        GoRoute(
          path: 'detail_berita',
          pageBuilder: (context, state) {
            return AppPageTransition.customTransitionPageSlidex(
              const DetailBeritaPage(),
            );
          },
        ),
        GoRoute(
          path: 'edit_profile',
          pageBuilder: (context, state) {
            return AppPageTransition.customTransitionPageSlidex(
              const EditProfilePage(),
            );
          },
        ),
        GoRoute(
          path: 'notif',
          pageBuilder: (context, state) {
            return AppPageTransition.customTransitionPageSlidex(
              const NotifPage(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return AppPageTransition.customTransitionPageSlidex(
          const LoginPage(),
        );
      },
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) {
        return AppPageTransition.customTransitionPageSlidex(
          const RegisterPage(),
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
