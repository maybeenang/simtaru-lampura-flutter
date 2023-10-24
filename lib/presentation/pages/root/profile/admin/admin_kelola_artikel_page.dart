import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/controllers/artikel/artikel_controller.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminKelolaArtikelPage extends HookConsumerWidget {
  const AdminKelolaArtikelPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artikelState = ref.watch(artikelControllerProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.refresh(artikelControllerProvider.notifier).getAllArtikel();
        },
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text("Admin Kelola Artikel"),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        const AdminTambahArtikelRoute().push(context);
                      },
                      child: const Text(
                        "Buat Artikel",
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            artikelState.when(
              data: (data) {
                if (data!.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text("Tidak ada data"),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Card(
                          color: AppColors.whiteColor,
                          child: ListTile(
                            title: Text(data[index].judul, maxLines: 2, overflow: TextOverflow.ellipsis),
                            subtitle: Text(data[index].isi, maxLines: 2, overflow: TextOverflow.ellipsis),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: data.length,
                  ),
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
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Card(
                          child: ListTile(
                            title: Container(
                              height: 20,
                              color: Colors.grey,
                            ),
                            subtitle: Container(
                              height: 20,
                              color: Colors.grey,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 5,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
