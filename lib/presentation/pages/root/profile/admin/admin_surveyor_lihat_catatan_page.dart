import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_surveyor_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AdminSurveyorLihatCatatanPage extends HookConsumerWidget {
  const AdminSurveyorLihatCatatanPage({super.key, required this.pengajuan});

  final Pengajuan pengajuan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Lihat Catatan"),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Catatan Pengajuan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "${pengajuan.nama_lengkap}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          FutureBuilder(
            future: ref.read(pengajuanSurveyorControllerProvider.notifier).getCatatanPengajuan(pengajuan.id.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text("Tidak ada catatan"),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Catatan",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${snapshot.data![index].keterangan}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Tanggal",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              DateFormat('dd-MM-yyyy').format(snapshot.data![index].created_at),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    },
                    childCount: snapshot.data!.length,
                  ),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
