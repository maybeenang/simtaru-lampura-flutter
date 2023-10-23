import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/presentation/controllers/status_pengajuan_controller.dart';
import 'package:flutter_map_simtaru/presentation/routes/router_listenable.dart';
import 'package:flutter_map_simtaru/utils/state_logger.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/image.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initializeDateFormatting('id_ID');
  runApp(
    const ProviderScope(
      observers: [
        StateLogger(),
      ],
      child: App(),
    ),
  );
}

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refreshNotifier = ref.watch(routerListenableProvider.notifier);
    ref.watch(statusPengajuanControllerProvider);
    final routes = useMemoized(
      () => GoRouter(
        routes: $appRoutes,
        initialLocation: SplashRoute.path,
        refreshListenable: refreshNotifier,
        redirect: refreshNotifier.redirect,
      ),
      [refreshNotifier],
    );
    precacheImage(const AssetImage(Images.bgPeta), context);
    precacheImage(const AssetImage(Images.logo), context);
    return GlobalLoaderOverlay(
      overlayOpacity: 0.5,
      overlayColor: AppColors.bgColor.withOpacity(0.5),
      child: MaterialApp.router(
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          elevatedButtonTheme: AppStyles.elevatedButtonThemeData,
          scaffoldBackgroundColor: AppColors.bgColor,
          appBarTheme: AppStyles.appBarTheme,
          fontFamily: 'Poppins',
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: routes,
      ),
    );
  }
}
