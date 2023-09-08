import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/presentation/controllers/auth_controller.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_listenable.g.dart';

@riverpod
class RouterListenable extends _$RouterListenable implements Listenable {
  VoidCallback? _routerListener;
  bool _isAuth = false;

  @override
  FutureOr<void> build() async {
    _isAuth = await ref.watch(
      authControllerProvider.selectAsync(
        (value) => value.map(
          signedIn: (_) => true,
          signedOut: (_) => false,
        ),
      ),
    );

    ref.listenSelf(
      (_, __) {
        // One could write more conditional logic for when to call redirection
        if (state.isLoading) return;
        _routerListener?.call();
      },
    );
  }

  String? redirect(BuildContext context, GoRouterState state) {
    if (this.state.isLoading || this.state.hasError) return null;
    print(state.uri.toString());

    final isSplash = state.uri.toString() == SplashRoute.path;
    if (isSplash) {
      return _isAuth ? RootRoute.path : OnBoardingRoute.path;
    }

    final isOnBoarding = state.uri.toString() == OnBoardingRoute.path;
    if (isOnBoarding) return _isAuth ? RootRoute.path : null;

    final isLogin = state.uri.toString() == LoginRoute.path;
    if (isLogin) return _isAuth ? RootRoute.path : null;

    final isRegister = state.uri.toString() == RegisterRoute.path;
    if (isRegister) return _isAuth ? RootRoute.path : null;

    final isRoot = state.uri.toString() == RootRoute.path;
    if (isRoot) return _isAuth ? null : LoginRoute.path;

    return _isAuth ? null : SplashRoute.path;
  }

  @override
  void addListener(VoidCallback listener) {
    _routerListener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    _routerListener = null;
  }
}
