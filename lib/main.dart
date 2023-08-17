import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/pages/login_page.dart';
import 'package:flutter_map_simtaru/pages/register_page.dart';
import 'package:flutter_map_simtaru/styles/styles.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const App());
}

final GoRouter _route = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) => const RegisterPage(),
  )
]);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        elevatedButtonTheme: AppStyles.elevatedButtonThemeData,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _route,
    );
  }
}
