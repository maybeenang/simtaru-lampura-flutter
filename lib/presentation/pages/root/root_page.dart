import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/controllers/roles/role_provider.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user_controller.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/peta/peta_page.dart';
import 'package:flutter_map_simtaru/presentation/controllers/index_screen_provider.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/berita/berita_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/home/home_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/pengajuan/overviewpengajuan_page.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/profile/profil_page.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// final PersistentTabController _controllerNavbar = PersistentTabController();
final controllerNavbarProvider = StateProvider.autoDispose<PersistentTabController>((ref) {
  return PersistentTabController();
});

// ignore: must_be_immutable
class RootPage extends ConsumerStatefulWidget {
  const RootPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends ConsumerState<RootPage> {
  List<Widget> _buildScreen() {
    return [
      const HomePage(),
      const OverviewPengajuanPage(),
      const PetaPage(),
      const BeritaPage(),
      const ProfilPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(currIndex) {
    return [
      PersistentBottomNavBarItem(
        icon: currIndex.index == 0 ? const Icon(Icons.home_rounded) : const Icon(Icons.home_outlined),
        title: ("Beranda"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
      ),
      PersistentBottomNavBarItem(
        icon: currIndex.index == 1 ? const Icon(Icons.note) : const Icon(Icons.note_outlined),
        title: ("Pengajuan"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
      ),
      PersistentBottomNavBarItem(
        iconSize: 40,
        icon: currIndex.index == 2
            ? const Icon(
                Icons.public,
                color: AppColors.whiteColor,
              )
            : const Icon(
                Icons.public_outlined,
                color: AppColors.whiteColor,
              ),
        title: (" "),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
      ),
      PersistentBottomNavBarItem(
        icon: currIndex.index == 3 ? const Icon(Icons.newspaper) : const Icon(Icons.newspaper_outlined),
        title: ("Artikel"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
      ),
      PersistentBottomNavBarItem(
        icon: currIndex.index == 4 ? const Icon(Icons.person) : const Icon(Icons.person_outline),
        title: ("Profil"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currIndex = ref.watch(indexScreenProvider);
    var controllerNavbar = ref.watch(controllerNavbarProvider);
    ref.watch(userControllerProvider);
    ref.watch(roleProvider);

    return CustomSafeArea(
      child: Scaffold(
        body: PersistentTabView(
          context,
          onItemSelected: (value) {
            ref.read(indexScreenProvider.notifier).onIndexChange(value);
          },
          controller: controllerNavbar,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(AppDouble.borderRadius),
            colorBehindNavBar: AppColors.bgColor,
            boxShadow: [
              AppStyles.boxShadowStyle,
            ],
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style15,
          items: _navBarsItems(currIndex),
          screens: _buildScreen(),
        ),
      ),
    );
  }
}
