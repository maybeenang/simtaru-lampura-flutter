import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:flutter_map_simtaru/pages/home_page.dart';
import 'package:flutter_map_simtaru/pages/informasi_page.dart';
import 'package:flutter_map_simtaru/pages/login_page.dart';
import 'package:flutter_map_simtaru/pages/pengajuan_page.dart';
import 'package:flutter_map_simtaru/pages/peta_page.dart';
import 'package:flutter_map_simtaru/pages/register_page.dart';
import 'package:flutter_map_simtaru/styles/styles.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const App());
}

final GoRouter _route = GoRouter(routes: <RouteBase>[
  GoRoute(path: '/', builder: (context, state) => const HomePage(), routes: [
    GoRoute(
      path: 'pengajuan',
      builder: (context, state) => const PengajuanPage(),
    ),
    GoRoute(
      path: 'peta',
      builder: (context, state) => const PetaPage(),
    ),
    GoRoute(
      path: 'informasi',
      builder: (context, state) => const InformasiPage(),
    ),
  ]),
  GoRoute(
    path: '/login',
    builder: (context, state) => LoginPage(),
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) => const RegisterPage(),
  ),
]);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
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
