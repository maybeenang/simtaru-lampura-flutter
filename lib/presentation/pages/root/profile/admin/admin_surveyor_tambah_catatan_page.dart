import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/controllers/form/form_state.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_surveyor_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AdminSurveyorTambahCatatanPage extends HookConsumerWidget {
  const AdminSurveyorTambahCatatanPage({
    super.key,
    required this.pengajuan,
  });

  final Pengajuan pengajuan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Catatan'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formTambahCatatanPengajuanKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Tambah Catatan Pengajuan",
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
                const Text(
                  "Catatan",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: inputController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Catatan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (formTambahCatatanPengajuanKey.currentState!.validate()) {
                      context.loaderOverlay.show();
                      final res = await ref.read(pengajuanSurveyorControllerProvider.notifier).tambahCatatanPengajuan(
                            pengajuan.id.toString(),
                            inputController.text,
                          );
                      if (context.mounted) {
                        context.loaderOverlay.hide();
                        if (res) {
                          context.pop();
                        }
                      }
                    }
                  },
                  child: const Text(
                    "Simpan",
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
      ),
    );
  }
}
