import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/custom_safe_area.dart';
import 'package:flutter_map_simtaru/components/drawer.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:flutter_map_simtaru/pages/berita_page.dart';
import 'package:flutter_map_simtaru/pages/home_page.dart';
import 'package:flutter_map_simtaru/pages/overviewpengajuan_page.dart';
import 'package:flutter_map_simtaru/pages/peta_page.dart';
import 'package:flutter_map_simtaru/states/providers/index_screen_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RootWidget extends ConsumerWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currIndex = ref.watch(indexScreenProvider);

    return CustomSafeArea(
      child: Scaffold(
        drawer: const DrawerApp(),
        body: IndexedStack(
          index: currIndex.index,
          children: const <Widget>[
            HomePage(),
            OverviewPengajuanPage(),
            PetaPage(),
            BeritaPage(),
            Center(
              child: Text("Profil"),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          elevation: 0,
          indicatorColor: AppColors.primaryColor,
          selectedIndex: currIndex.index,
          onDestinationSelected: (index) {
            ref.read(indexScreenProvider.notifier).onIndexChange(index);
          },
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home, color: AppColors.whiteColor),
              icon: Icon(Icons.home_outlined),
              label: 'Beranda',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.note, color: AppColors.whiteColor),
              icon: Icon(Icons.note_outlined),
              label: 'Pengajuan',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.map, color: AppColors.whiteColor),
              icon: Icon(Icons.map_outlined),
              label: 'Peta',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.newspaper, color: AppColors.whiteColor),
              icon: Icon(Icons.newspaper_outlined),
              label: 'Berita',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person, color: AppColors.whiteColor),
              icon: Icon(Icons.person_outline),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
