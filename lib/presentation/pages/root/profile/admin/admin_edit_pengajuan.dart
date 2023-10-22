import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/controllers/form/form_state.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_verifikasi_berkas_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_verifikasi_lapangan_controller.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_common.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AdminEditPengajuanPage extends HookConsumerWidget {
  const AdminEditPengajuanPage({super.key, required this.pengajuan});

  final Pengajuan pengajuan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = List.generate(18, (index) => useTextEditingController());

    void handleSubmitEditPengajuan() async {
      if (formEditPengajuanKey.currentState!.validate()) {
        context.loaderOverlay.show();
        try {
          final formData = FormData.fromMap({
            'nama_lengkap': inputController[0].value.text,
            'tempat_tanggal_lahir': inputController[1].value.text,
            'alamat': inputController[2].value.text,
            'pekerjaan': inputController[3].value.text,
            'no_identitas': inputController[4].value.text,
            'no_hp': inputController[5].value.text,
            'bertindak_atas_nama': inputController[6].value.text,
            'penggunaan_tanah_saat_dimohon': inputController[7].value.text,
            'luas_tanah_seluruhnya': inputController[8].value.text,
            'luas_tanah_yang_dimohon': inputController[9].value.text,
            'bukti_penguasaan_tanah': inputController[10].value.text,
            'letak_tanah': inputController[11].value.text,
            'rencana_penggunaan_tanah': inputController[12].value.text,
            'batas_sebelah_utara': inputController[13].value.text,
            'batas_sebelah_timur': inputController[14].value.text,
            'batas_sebelah_selatan': inputController[15].value.text,
            'batas_sebelah_barat': inputController[16].value.text,
            'titik_koordinat': inputController[17].value.text,
          });
          print(formData.fields);
          final url = Endpoints.baseURL + Endpoints.updatePengajuan + pengajuan.id.toString();
          final Dio dio = Dio();

          await dio.post(
            url,
            data: formData,
          );

          if (context.mounted) {
            context.loaderOverlay.hide();
            ref.invalidate(pengajuanVerifikasiLapanganControllerProvider);
            ref.invalidate(pengajuanVerifikasiBerkasControllerProvider);
            Flushbar(
              message: "Berhasil mengedit pengajuan",
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
            ).show(context).then(
              (value) {
                context.pop();
              },
            );
          }
        } on DioException catch (_) {
          if (context.mounted) {
            context.loaderOverlay.hide();
            Flushbar(
              message: "Gagal mengedit pengajuan",
              backgroundColor: AppColors.redColor,
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
            );
          }
        } finally {
          if (context.mounted) {
            context.loaderOverlay.hide();
          }
        }
      }
    }

    return CustomSafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Data Lapangan"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  "Edit Pengajuan atas nama ${pengajuan.nama_lengkap}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.redColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Text(
                    "Pengajuan ini akan diproses oleh pihak terkait. Pastikan data yang anda masukkan sudah benar.",
                    style: TextStyle(
                      color: AppColors.redColor,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: formEditPengajuanKey,
                  child: Column(
                    children: [
                      TextFieldCommon(
                        labelText: "Nama Lengkap",
                        initialValue: pengajuan.nama_lengkap,
                        controller: inputController[0],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Tempat tanggal lahir",
                        initialValue: pengajuan.tempat_tanggal_lahir,
                        controller: inputController[1],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Alamat",
                        initialValue: pengajuan.alamat,
                        controller: inputController[2],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Pekerjaan",
                        initialValue: pengajuan.pekerjaan,
                        controller: inputController[3],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "No Identitas / NIK",
                        initialValue: pengajuan.no_identitas,
                        controller: inputController[4],
                        isNik: true,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "No Hp/Telepon",
                        initialValue: pengajuan.no_hp,
                        controller: inputController[5],
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Bertindak atas nama",
                        initialValue: pengajuan.bertindak_atas_nama,
                        controller: inputController[6],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Penggunaan tanah saat dimohon",
                        initialValue: pengajuan.penggunaan_tanah_saat_dimohon,
                        controller: inputController[7],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Luas tanah seluruhnya dalam m2",
                        initialValue: pengajuan.luas_tanah_seluruhnya,
                        controller: inputController[8],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Luas tanah yang dimohon dalam m2",
                        initialValue: pengajuan.luas_tanah_yang_dimohon,
                        controller: inputController[9],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Bukti penguasaan tanah",
                        initialValue: pengajuan.bukti_penguasaan_tanah,
                        controller: inputController[10],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Letak tanah",
                        initialValue: pengajuan.letak_tanah,
                        controller: inputController[11],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Rencana Penggunaan Tanah",
                        initialValue: pengajuan.rencana_penggunaan_tanah,
                        controller: inputController[12],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Batas sebelah utara",
                        initialValue: pengajuan.batas_sebelah_utara,
                        controller: inputController[13],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Batas sebelah timur",
                        initialValue: pengajuan.batas_sebelah_timur,
                        controller: inputController[14],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Batas sebelah selatan",
                        initialValue: pengajuan.batas_sebelah_selatan,
                        controller: inputController[15],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Batas sebelah barat",
                        initialValue: pengajuan.batas_sebelah_barat,
                        controller: inputController[16],
                      ),
                      const SizedBox(height: 10),
                      TextFieldCommon(
                        labelText: "Titik koordinat",
                        initialValue: pengajuan.titik_koordinat,
                        controller: inputController[17],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    handleSubmitEditPengajuan();
                  },
                  child: const Text(
                    "Kirim",
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
