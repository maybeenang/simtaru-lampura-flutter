import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user/admin_user_controller.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/loading/user_item_card_loading.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/user_item_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminKelolaUserPage extends HookConsumerWidget {
  const AdminKelolaUserPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showScrollToTop = useState(false);
    final hasReachedMax = useState(false);

    final userGetAllState = ref.watch(adminUserControllerProvider);

    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        final newValue = ref.read(adminUserControllerProvider.notifier).loadMore();
        newValue.then((value) => hasReachedMax.value = value);
      }

      if (scrollController.position.pixels >= 100) {
        showScrollToTop.value = true;
      } else {
        showScrollToTop.value = false;
      }
    });

    return CustomSafeArea(
      child: Scaffold(
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
        appBar: AppBar(
          title: const Text("Admin Kelola User"),
        ),
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            userGetAllState.maybeWhen(
              orElse: () => const SliverToBoxAdapter(
                child: SizedBox(height: 30),
              ),
              data: (data) {
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Tambah User",
                            style: TextStyle(color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
            userGetAllState.when(
              data: (data) {
                if (data?.isEmpty ?? true) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text("Data Kosong"),
                    ),
                  );
                }
                return SliverList.separated(
                  itemCount: hasReachedMax.value
                      ? data!.length
                      : data!.length > 5
                          ? data.length + 2
                          : data.length,
                  itemBuilder: (context, index) {
                    return index >= data.length
                        ? const UserItemCardLoading()
                        : UserItemCard(
                            user: data[index],
                          );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                );
              },
              error: (error, stackTrace) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(error.toString()),
                  ),
                );
              },
              loading: () {
                return SliverList.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const UserItemCardLoading();
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                );
              },
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
