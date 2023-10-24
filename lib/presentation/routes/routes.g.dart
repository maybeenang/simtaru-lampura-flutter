// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $rootRoute,
      $loginRoute,
      $registerRoute,
      $onBoardingRoute,
    ];

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/splash',
      factory: $SplashRouteExtension._fromState,
    );

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  String get location => GoRouteData.$location(
        '/splash',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $rootRoute => GoRouteData.$route(
      path: '/',
      factory: $RootRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'pengajuan',
          factory: $PengajuanRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'search_pengajuan',
          factory: $SearchPengajaunRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'detail_pengajuan',
          factory: $DetailPengajuanRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'detail_berita',
          factory: $DetailBeritaRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'edit_profile',
          factory: $EditProfileRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'edit_password_profile',
          factory: $EditPasswordProfileRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'notif',
          factory: $NotifRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-seluruh-pengajuan',
          factory: $AdminSeluruhPengajuanRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-pengajuan-ditolak',
          factory: $AdminPengajuanDitolahRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-surat-rekomendasi',
          factory: $AdminSuratRekomendasiRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-upload-scan-surat',
          factory: $AdminUploadScanSuratRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-verifikasi-lapangan',
          factory: $AdminVerifikasiLapanganRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-verifikasi-berkas',
          factory: $AdminVerifikasiBerkasRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-revisi-berkas',
          factory: $AdminRevisiBerkasRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-ubah-status',
          factory: $AdminUbahStatusRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-edit-pengajuan',
          factory: $AdminEditPengajuanRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-rekam-polygon',
          factory: $AdminRekamPolygonRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-edit-data-lapangan',
          factory: $AdminEditDataLapanganRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-kelola-user',
          factory: $AdminKelolaUserRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-edit-user',
          factory: $AdminEditUserRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-tambah-user',
          factory: $AdminTambahUserRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-kelola-artikel',
          factory: $AdminKelolaArtikelRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-tambah-artikel',
          factory: $AdminTambahArtikelRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'admin-edit-artikel',
          factory: $AdminEditArtikelRouteExtension._fromState,
        ),
      ],
    );

extension $RootRouteExtension on RootRoute {
  static RootRoute _fromState(GoRouterState state) => const RootRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PengajuanRouteExtension on PengajuanRoute {
  static PengajuanRoute _fromState(GoRouterState state) =>
      const PengajuanRoute();

  String get location => GoRouteData.$location(
        '/pengajuan',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SearchPengajaunRouteExtension on SearchPengajaunRoute {
  static SearchPengajaunRoute _fromState(GoRouterState state) =>
      const SearchPengajaunRoute();

  String get location => GoRouteData.$location(
        '/search_pengajuan',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DetailPengajuanRouteExtension on DetailPengajuanRoute {
  static DetailPengajuanRoute _fromState(GoRouterState state) =>
      DetailPengajuanRoute(
        state.extra as Pengajuan,
      );

  String get location => GoRouteData.$location(
        '/detail_pengajuan',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $DetailBeritaRouteExtension on DetailBeritaRoute {
  static DetailBeritaRoute _fromState(GoRouterState state) => DetailBeritaRoute(
        state.extra as Artikel,
      );

  String get location => GoRouteData.$location(
        '/detail_berita',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $EditProfileRouteExtension on EditProfileRoute {
  static EditProfileRoute _fromState(GoRouterState state) =>
      const EditProfileRoute();

  String get location => GoRouteData.$location(
        '/edit_profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EditPasswordProfileRouteExtension on EditPasswordProfileRoute {
  static EditPasswordProfileRoute _fromState(GoRouterState state) =>
      const EditPasswordProfileRoute();

  String get location => GoRouteData.$location(
        '/edit_password_profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NotifRouteExtension on NotifRoute {
  static NotifRoute _fromState(GoRouterState state) => const NotifRoute();

  String get location => GoRouteData.$location(
        '/notif',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminSeluruhPengajuanRouteExtension on AdminSeluruhPengajuanRoute {
  static AdminSeluruhPengajuanRoute _fromState(GoRouterState state) =>
      const AdminSeluruhPengajuanRoute();

  String get location => GoRouteData.$location(
        '/admin-seluruh-pengajuan',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminPengajuanDitolahRouteExtension on AdminPengajuanDitolahRoute {
  static AdminPengajuanDitolahRoute _fromState(GoRouterState state) =>
      const AdminPengajuanDitolahRoute();

  String get location => GoRouteData.$location(
        '/admin-pengajuan-ditolak',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminSuratRekomendasiRouteExtension on AdminSuratRekomendasiRoute {
  static AdminSuratRekomendasiRoute _fromState(GoRouterState state) =>
      const AdminSuratRekomendasiRoute();

  String get location => GoRouteData.$location(
        '/admin-surat-rekomendasi',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminUploadScanSuratRouteExtension on AdminUploadScanSuratRoute {
  static AdminUploadScanSuratRoute _fromState(GoRouterState state) =>
      const AdminUploadScanSuratRoute();

  String get location => GoRouteData.$location(
        '/admin-upload-scan-surat',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminVerifikasiLapanganRouteExtension
    on AdminVerifikasiLapanganRoute {
  static AdminVerifikasiLapanganRoute _fromState(GoRouterState state) =>
      const AdminVerifikasiLapanganRoute();

  String get location => GoRouteData.$location(
        '/admin-verifikasi-lapangan',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminVerifikasiBerkasRouteExtension on AdminVerifikasiBerkasRoute {
  static AdminVerifikasiBerkasRoute _fromState(GoRouterState state) =>
      const AdminVerifikasiBerkasRoute();

  String get location => GoRouteData.$location(
        '/admin-verifikasi-berkas',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminRevisiBerkasRouteExtension on AdminRevisiBerkasRoute {
  static AdminRevisiBerkasRoute _fromState(GoRouterState state) =>
      const AdminRevisiBerkasRoute();

  String get location => GoRouteData.$location(
        '/admin-revisi-berkas',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminUbahStatusRouteExtension on AdminUbahStatusRoute {
  static AdminUbahStatusRoute _fromState(GoRouterState state) =>
      const AdminUbahStatusRoute();

  String get location => GoRouteData.$location(
        '/admin-ubah-status',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminEditPengajuanRouteExtension on AdminEditPengajuanRoute {
  static AdminEditPengajuanRoute _fromState(GoRouterState state) =>
      AdminEditPengajuanRoute(
        state.extra as Pengajuan,
      );

  String get location => GoRouteData.$location(
        '/admin-edit-pengajuan',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $AdminRekamPolygonRouteExtension on AdminRekamPolygonRoute {
  static AdminRekamPolygonRoute _fromState(GoRouterState state) =>
      AdminRekamPolygonRoute(
        state.extra as Pengajuan,
      );

  String get location => GoRouteData.$location(
        '/admin-rekam-polygon',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $AdminEditDataLapanganRouteExtension on AdminEditDataLapanganRoute {
  static AdminEditDataLapanganRoute _fromState(GoRouterState state) =>
      AdminEditDataLapanganRoute(
        state.extra as Pengajuan,
      );

  String get location => GoRouteData.$location(
        '/admin-edit-data-lapangan',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $AdminKelolaUserRouteExtension on AdminKelolaUserRoute {
  static AdminKelolaUserRoute _fromState(GoRouterState state) =>
      const AdminKelolaUserRoute();

  String get location => GoRouteData.$location(
        '/admin-kelola-user',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminEditUserRouteExtension on AdminEditUserRoute {
  static AdminEditUserRoute _fromState(GoRouterState state) =>
      AdminEditUserRoute(
        state.extra as UserUtils,
      );

  String get location => GoRouteData.$location(
        '/admin-edit-user',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $AdminTambahUserRouteExtension on AdminTambahUserRoute {
  static AdminTambahUserRoute _fromState(GoRouterState state) =>
      const AdminTambahUserRoute();

  String get location => GoRouteData.$location(
        '/admin-tambah-user',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminKelolaArtikelRouteExtension on AdminKelolaArtikelRoute {
  static AdminKelolaArtikelRoute _fromState(GoRouterState state) =>
      const AdminKelolaArtikelRoute();

  String get location => GoRouteData.$location(
        '/admin-kelola-artikel',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminTambahArtikelRouteExtension on AdminTambahArtikelRoute {
  static AdminTambahArtikelRoute _fromState(GoRouterState state) =>
      const AdminTambahArtikelRoute();

  String get location => GoRouteData.$location(
        '/admin-tambah-artikel',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminEditArtikelRouteExtension on AdminEditArtikelRoute {
  static AdminEditArtikelRoute _fromState(GoRouterState state) =>
      AdminEditArtikelRoute(
        state.extra as Artikel,
      );

  String get location => GoRouteData.$location(
        '/admin-edit-artikel',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginRouteExtension._fromState,
    );

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $registerRoute => GoRouteData.$route(
      path: '/register',
      factory: $RegisterRouteExtension._fromState,
    );

extension $RegisterRouteExtension on RegisterRoute {
  static RegisterRoute _fromState(GoRouterState state) => const RegisterRoute();

  String get location => GoRouteData.$location(
        '/register',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onBoardingRoute => GoRouteData.$route(
      path: '/on_boarding',
      factory: $OnBoardingRouteExtension._fromState,
    );

extension $OnBoardingRouteExtension on OnBoardingRoute {
  static OnBoardingRoute _fromState(GoRouterState state) =>
      const OnBoardingRoute();

  String get location => GoRouteData.$location(
        '/on_boarding',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
