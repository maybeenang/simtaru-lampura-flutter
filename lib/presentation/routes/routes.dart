import 'package:flutter/widgets.dart';
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
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedGoRoute<RootRoute>(
  path: RootRoute.path,
  routes: [
    TypedGoRoute<PengajuanRoute>(path: PengajuanRoute.path),
    TypedGoRoute<SearchPengajaunRoute>(path: SearchPengajaunRoute.path),
    TypedGoRoute<DetailPengajuanRoute>(path: DetailPengajuanRoute.path),
    TypedGoRoute<DetailBeritaRoute>(path: DetailBeritaRoute.path),
    TypedGoRoute<EditProfileRoute>(path: EditProfileRoute.path),
    TypedGoRoute<NotifRoute>(path: NotifRoute.path),
  ],
)
class RootRoute extends GoRouteData {
  const RootRoute();
  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RootWidget();
  }
}

class PengajuanRoute extends GoRouteData {
  const PengajuanRoute();
  static const path = 'pengajuan';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PengajuanPage();
  }
}

class SearchPengajaunRoute extends GoRouteData {
  const SearchPengajaunRoute();
  static const path = 'search_pengajuan';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SearchPengajuanPage();
  }
}

class DetailPengajuanRoute extends GoRouteData {
  const DetailPengajuanRoute();
  static const path = 'detail_pengajuan';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DetailPengajuanPage();
  }
}

class DetailBeritaRoute extends GoRouteData {
  const DetailBeritaRoute();
  static const path = 'detail_berita';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DetailBeritaPage();
  }
}

class EditProfileRoute extends GoRouteData {
  const EditProfileRoute();
  static const path = 'edit_profile';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EditProfilePage();
  }
}

class NotifRoute extends GoRouteData {
  const NotifRoute();
  static const path = 'notif';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NotifPage();
  }
}

@TypedGoRoute<LoginRoute>(path: LoginRoute.path)
class LoginRoute extends GoRouteData {
  const LoginRoute();
  static const path = '/login';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}

@TypedGoRoute<RegisterRotue>(path: RegisterRotue.path)
class RegisterRotue extends GoRouteData {
  const RegisterRotue();
  static const path = '/register';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RegisterPage();
  }
}

@TypedGoRoute<OnBoardingRoute>(path: OnBoardingRoute.path)
class OnBoardingRoute extends GoRouteData {
  const OnBoardingRoute();
  static const path = '/on_boarding';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OnBoardingPage();
  }
}
