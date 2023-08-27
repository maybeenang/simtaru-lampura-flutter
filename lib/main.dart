import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:flutter_map_simtaru/constants/image.dart';
import 'package:flutter_map_simtaru/pages/detail_pengajuan_page.dart';
import 'package:flutter_map_simtaru/pages/login_page.dart';
import 'package:flutter_map_simtaru/pages/pengajuan_page.dart';
import 'package:flutter_map_simtaru/pages/register_page.dart';
import 'package:flutter_map_simtaru/pages/root_page.dart';
import 'package:flutter_map_simtaru/styles/styles.dart';
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
          builder: (context, state) => const PengajuanPage(),
        ),
        GoRoute(
          path: 'detail_pengajuan',
          builder: (context, state) => const DetailPengajuanPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
  ],
  initialLocation: '/login',
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
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _route,
    );
  }
}
