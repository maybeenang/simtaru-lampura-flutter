import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/controllers/artikel/artikel_controller.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AdminKelolaArtikelPage extends HookConsumerWidget {
  const AdminKelolaArtikelPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artikelState = ref.watch(artikelControllerProvider);

    void handlDeleteArtikel(String id) async {
      final result = await ref.read(artikelControllerProvider.notifier).deleteArtikel(id);

      if (result == "Berhasil Hapus Artikel") {
        if (context.mounted) {
          context.loaderOverlay.hide();
          Flushbar(
            message: "Berhasil Hapus Artikel",
            backgroundColor: AppColors.greenColor,
            duration: const Duration(seconds: 1),
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.FLOATING,
            animationDuration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(8),
            isDismissible: true,
            shouldIconPulse: false,
            icon: const Icon(
              Icons.check,
              color: AppColors.whiteColor,
            ),
          ).show(context);
        }
      } else {
        if (context.mounted) {
          context.loaderOverlay.hide();
          Flushbar(
            message: "Gagal Hapus Artikel",
            backgroundColor: AppColors.redColor,
            duration: const Duration(seconds: 3),
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.FLOATING,
            animationDuration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(8),
            isDismissible: true,
            shouldIconPulse: false,
            icon: const Icon(
              Icons.close,
              color: AppColors.whiteColor,
            ),
          ).show(context);
        }
      }
    }

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
                    const SizedBox(
                      height: 20,
                    ),
                    artikelState.maybeWhen(
                      data: (data) {
                        return ElevatedButton(
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
                        );
                      },
                      orElse: () {
                        return const SizedBox();
                      },
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
                        decoration: BoxDecoration(
                          boxShadow: [
                            AppStyles.boxShadowStyle,
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Card(
                          elevation: 0,
                          color: AppColors.whiteColor,
                          child: ListTile(
                            onTap: () {
                              Future.delayed(
                                const Duration(milliseconds: 300),
                                () {
                                  DetailBeritaRoute(data[index]).push(context);
                                },
                              );
                            },
                            title: Text(
                              data[index].judul,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            subtitle: Text(
                              data[index].isi,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    AdminEditArtikelRoute(data[index]).push(context);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.loaderOverlay.show();
                                    handlDeleteArtikel(data[index].id.toString());
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColors.redColor,
                                  ),
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
                        decoration: BoxDecoration(
                          boxShadow: [
                            AppStyles.boxShadowStyle,
                          ],
                        ),
                        child: Card(
                          elevation: 0,
                          color: AppColors.whiteColor,
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
