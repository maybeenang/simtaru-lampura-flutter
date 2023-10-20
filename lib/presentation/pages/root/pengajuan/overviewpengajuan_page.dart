import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/domain/entity/role/role.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_user_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/roles/role_provider.dart';
import 'package:flutter_map_simtaru/presentation/controllers/status_pengajuan_controller.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_search_pengajuan.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/carousel_pengajuan_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/item_pengajuan_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/loading/item_pengajuan_loading.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_appbar_fitur.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OverviewPengajuanPage extends HookConsumerWidget {
  const OverviewPengajuanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showScrollToTop = useState(false);
    final hasReachedMax = useState(false);
    final roleState = ref.watch(roleProvider);
    final pengajuanState =
        roleState is Admin ? ref.watch(pengajuanControllerProvider) : ref.watch(pengajuanUserControllerProvider);
    ref.watch(statusPengajuanControllerProvider);

    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        final newValue = roleState is Admin
            ? ref.read(pengajuanControllerProvider.notifier).loadMore()
            : ref.read(pengajuanUserControllerProvider.notifier).loadMore();
        newValue.then((value) => hasReachedMax.value = value);
      }

      if (scrollController.position.pixels >= 100) {
        showScrollToTop.value = true;
      } else {
        showScrollToTop.value = false;
      }
    });

    return Scaffold(
      floatingActionButton: showScrollToTop.value
          ? Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: FloatingActionButton(
                onPressed: () {
                  scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                backgroundColor: AppColors.primaryColor,
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.arrow_upward,
                  color: AppColors.whiteColor,
                ),
              ),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () async {
          if (roleState is Admin) {
            await ref.refresh(pengajuanControllerProvider.notifier).getPengajuan();
          } else {
            await ref.refresh(pengajuanUserControllerProvider.notifier).getPengajuan();
          }
        },
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const CustomAppBarFitur(
                    title: "Pengajuan",
                    bgColor: AppColors.primaryColor,
                    labelColor: AppColors.whiteColor,
                  ),
                  Stack(
                    children: [
                      Container(
                        color: AppColors.primaryColor,
                        child: const SizedBox(
                          width: double.infinity,
                          height: 25,
                        ),
                      ),
                      const ButtonSearchPengajuan(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  roleState is Admin ? const CarouselPengajuanCard() : const SizedBox(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            pengajuanState.maybeWhen(
              orElse: () {
                return SliverList.separated(
                  itemCount: 5,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppDouble.paddingOutside),
                      child: ItemPengajuanLoading(),
                    );
                  },
                );
              },
              data: (data) {
                if (data!.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text("Tidak ada pengajuan"),
                    ),
                  );
                }

                return SliverList.separated(
                  itemCount: hasReachedMax.value
                      ? data.length
                      : data.length > 5
                          ? data.length + 3
                          : data.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDouble.paddingOutside,
                      ),
                      child: index >= data.length
                          ? const ItemPengajuanLoading()
                          : ItemPengajuanCard(
                              pengajuan: data[index],
                            ),
                    );
                  },
                );
              },
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            )
          ],
        ),
      ),
    );
  }
}
