import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/pages/login_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/onboarding_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/register_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/berita/detail_berita_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/pengajuan/detail_pengajuan_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/home/notif_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/pengajuan/pengajuan_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/pengajuan/search_pengajuan_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/profile/admin/admin_pengajuan_ditolak_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/profile/admin/admin_revisi_berkas_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/profile/admin/admin_seluruh_pengajuan_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/profile/admin/admin_surat_rekomendasi_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/profile/admin/admin_upload_scan_surat_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/profile/admin/admin_verifikasi_berkas_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/profile/admin/admin_verifikasi_lapangan_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/profile/edit_profile_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/root_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/splash_page.dart';
import 'package:flutter_map_simtaru/presentation/widgets/animations/custom_transition_page.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedGoRoute<SplashRoute>(path: SplashRoute.path)
class SplashRoute extends GoRouteData {
  const SplashRoute();
  static const path = '/splash';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashPage();
  }
}

@TypedGoRoute<RootRoute>(
  path: RootRoute.path,
  routes: [
    TypedGoRoute<PengajuanRoute>(path: PengajuanRoute.path),
    TypedGoRoute<SearchPengajaunRoute>(path: SearchPengajaunRoute.path),
    TypedGoRoute<DetailPengajuanRoute>(path: DetailPengajuanRoute.path),
    TypedGoRoute<DetailBeritaRoute>(path: DetailBeritaRoute.path),
    TypedGoRoute<EditProfileRoute>(path: EditProfileRoute.path),
    TypedGoRoute<NotifRoute>(path: NotifRoute.path),
    TypedGoRoute<AdminSeluruhPengajuanRoute>(path: AdminSeluruhPengajuanRoute.path),
    TypedGoRoute<AdminPengajuanDitolahRoute>(path: AdminPengajuanDitolahRoute.path),
    TypedGoRoute<AdminSuratRekomendasiRoute>(path: AdminSuratRekomendasiRoute.path),
    TypedGoRoute<AdminUploadScanSuratRoute>(path: AdminUploadScanSuratRoute.path),
    TypedGoRoute<AdminVerifikasiLapanganRoute>(path: AdminVerifikasiLapanganRoute.path),
    TypedGoRoute<AdminVerifikasiBerkasRoute>(path: AdminVerifikasiBerkasRoute.path),
    TypedGoRoute<AdminRevisiBerkasRoute>(path: AdminRevisiBerkasRoute.path),
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
  buildPage(BuildContext context, GoRouterState state) =>
      AppPageTransition.customTransitionPageFade(const SearchPengajuanPage());
}

class DetailPengajuanRoute extends GoRouteData {
  const DetailPengajuanRoute(this.$extra);
  final Pengajuan $extra;
  static const path = 'detail_pengajuan';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DetailPengajuanPage(
      pengajuan: $extra,
    );
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

class AdminSeluruhPengajuanRoute extends GoRouteData {
  const AdminSeluruhPengajuanRoute();
  static const path = 'admin-seluruh-pengajuan';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminSeluruhPengajuanPage();
  }
}

class AdminPengajuanDitolahRoute extends GoRouteData {
  const AdminPengajuanDitolahRoute();
  static const path = 'admin-pengajuan-ditolak';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminPengajuanDitolakPage();
  }
}

class AdminSuratRekomendasiRoute extends GoRouteData {
  const AdminSuratRekomendasiRoute();
  static const path = 'admin-surat-rekomendasi';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminSuratRekomendasiPage();
  }
}

class AdminUploadScanSuratRoute extends GoRouteData {
  const AdminUploadScanSuratRoute();
  static const path = 'admin-upload-scan-surat';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminUploadScanSuratPage();
  }
}

class AdminVerifikasiLapanganRoute extends GoRouteData {
  const AdminVerifikasiLapanganRoute();
  static const path = 'admin-verifikasi-lapangan';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminVerifikasiLapanganPage();
  }
}

class AdminVerifikasiBerkasRoute extends GoRouteData {
  const AdminVerifikasiBerkasRoute();
  static const path = 'admin-verifikasi-berkas';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminVerifikasiBerkasPage();
  }
}

class AdminRevisiBerkasRoute extends GoRouteData {
  const AdminRevisiBerkasRoute();
  static const path = 'admin-revisi-berkas';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminRevisiBerkasPage();
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

@TypedGoRoute<RegisterRoute>(path: RegisterRoute.path)
class RegisterRoute extends GoRouteData {
  const RegisterRoute();
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
