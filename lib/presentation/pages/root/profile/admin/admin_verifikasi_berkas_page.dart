import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/presentation/controllers/form/form_state.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_verifikasi_berkas_controller.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_action_pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_search_pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/bottom_sheet_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/item_pengajuan_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/loading/item_pengajuan_loading.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_appbar_fitur.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AdminVerifikasiBerkasPage extends HookConsumerWidget {
  const AdminVerifikasiBerkasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showScrollToTop = useState(false);
    final hasReachedMax = useState(false);
    final pengajuanVerifikasiBerkasState = ref.watch(pengajuanVerifikasiBerkasControllerProvider);

    final scrollController = ScrollController();

    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        final newValue = ref.read(pengajuanVerifikasiBerkasControllerProvider.notifier).loadMore();
        newValue.then((value) => hasReachedMax.value = value);
      }

      if (scrollController.position.pixels >= 100) {
        showScrollToTop.value = true;
      } else {
        showScrollToTop.value = false;
      }
    });

    Future setujuiPengajuan(int pengajuanId, String pengajuanNama) async {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: "Peringatan",
        barrierDismissible: false,
        text: 'Anda yakin pengajuan atas nama $pengajuanNama, lolos verifikasi berkas?',
        confirmBtnText: 'Ya',
        cancelBtnText: 'Batal',
        confirmBtnColor: Colors.green,
        onConfirmBtnTap: () async {
          Navigator.pop(context);
          context.loaderOverlay.show();
          String url = "${Endpoints.baseURL}${Endpoints.updateStatusPengajuan}$pengajuanId";
          final Dio dio = Dio();
          try {
            await dio.put(
              url,
              data: {
                "status_id": 3,
              },
            );
            ref.invalidate(pengajuanVerifikasiBerkasControllerProvider);
            await ref.refresh(pengajuanControllerProvider.notifier).getPengajuan();
            if (context.mounted) {
              context.loaderOverlay.hide();
            }
          } catch (e) {
            if (context.mounted) {
              context.loaderOverlay.hide();
            }
            return Future.error(e.toString());
          } finally {
            if (context.mounted) {
              context.loaderOverlay.hide();
            }
          }
        },
      );
    }

    final inputAlasanDitolakController = useTextEditingController();

    Future tolakPengajuan(int pengajuanId, String pengajuanNama) async {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.custom,
        barrierDismissible: true,
        title: "Peringatan",
        text: 'Anda yakin pengajuan atas nama $pengajuanNama, gagal verifikasi berkas?',
        widget: Form(
          key: alasanDitolakKey,
          child: TextFormField(
            controller: inputAlasanDitolakController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Alasan tidak boleh kosong';
              }
              return null;
            },
            decoration: const InputDecoration(
              alignLabelWithHint: true,
              hintText: 'Alasan ditolak',
              prefixIcon: Icon(
                Icons.info,
              ),
            ),
          ),
        ),
        headerBackgroundColor: AppColors.redColor,
        showConfirmBtn: true,
        showCancelBtn: true,
        confirmBtnText: 'Ya',
        cancelBtnText: 'Batal',
        confirmBtnColor: AppColors.redColor,
        onConfirmBtnTap: () async {
          if (alasanDitolakKey.currentState!.validate()) {
            Navigator.pop(context);
            context.loaderOverlay.show();
            String url = "${Endpoints.baseURL}${Endpoints.updateStatusPengajuan}$pengajuanId";
            final Dio dio = Dio();
            try {
              await dio.put(
                url,
                data: {
                  "status_id": 1,
                  "alasan_ditolak": inputAlasanDitolakController.text,
                },
              );
              ref.invalidate(pengajuanVerifikasiBerkasControllerProvider);
              ref.invalidate(pengajuanControllerProvider);

              await ref.refresh(pengajuanControllerProvider.notifier).getPengajuan();
              if (context.mounted) {
                context.loaderOverlay.hide();
              }
            } catch (e) {
              if (context.mounted) {
                context.loaderOverlay.hide();
              }
              return Future.error(e.toString());
            } finally {
              if (context.mounted) {
                context.loaderOverlay.hide();
              }
            }
          }
        },
      );
    }

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
        body: RefreshIndicator(
          onRefresh: () async {
            await ref.read(pengajuanVerifikasiBerkasControllerProvider.notifier).getPengajuan();
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const CustomAppBarFitur(
                      title: "Admin Verifikasi Berkas",
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
                  ],
                ),
              ),
              pengajuanVerifikasiBerkasState.maybeWhen(
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
                  if (data.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text("Tidak ada data"),
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
                                onTap: () {
                                  Future.delayed(
                                    const Duration(milliseconds: 100),
                                    () => showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return BottomSheetCard(
                                          pengajuan: data[index],
                                          actions: [
                                            ButtonActionPengajuan(
                                              label: "Setujui",
                                              icon: Icons.check,
                                              color: AppColors.greenColor,
                                              onTap: () async {
                                                context.pop();
                                                setujuiPengajuan(data[index].id, data[index].nama_lengkap!);
                                              },
                                            ),
                                            const SizedBox(height: 5),
                                            ButtonActionPengajuan(
                                              label: "Tolak",
                                              icon: Icons.close,
                                              color: AppColors.redColor,
                                              onTap: () {
                                                context.pop();
                                                tolakPengajuan(data[index].id, data[index].nama_lengkap!);
                                              },
                                            ),
                                            const SizedBox(height: 5),
                                            ButtonActionPengajuan(
                                              label: "Edit",
                                              icon: Icons.edit,
                                              color: AppColors.mapColorStatusChip[2]!,
                                              onTap: () {
                                                context.pop();
                                                AdminEditPengajuanRoute(data[index]).push(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                      );
                    },
                  );
                },
              ),
              const SliverFillRemaining(),
            ],
          ),
        ),
      ),
    );
  }
}
