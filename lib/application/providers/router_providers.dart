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
import 'package:flutter_map_simtaru/presentation/widgets/animations/custom_transition_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    final router = RouterNotifier(ref);
    return GoRouter(
      debugLogDiagnostics: true,
      routes: router._routes,
    );
  },
);

class RouterNotifier extends StateNotifier {
  final Ref _ref;
  RouterNotifier(this._ref) : super(null);

  List<GoRoute> get _routes => [
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
        ),
      ];
}
