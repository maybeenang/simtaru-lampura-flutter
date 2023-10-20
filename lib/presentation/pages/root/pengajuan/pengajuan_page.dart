import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/role/role.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/presentation/controllers/form/form_state.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_user_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/roles/role_provider.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user_controller.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/widgets/forms/langkah1_form.dart';
import 'package:flutter_map_simtaru/presentation/widgets/forms/langkah2_form.dart';
import 'package:flutter_map_simtaru/presentation/widgets/forms/langkah3_form.dart';
import 'package:flutter_map_simtaru/presentation/widgets/forms/langkah4_form.dart';
import 'package:flutter_map_simtaru/presentation/widgets/forms/langkah5_form.dart';
import 'package:flutter_map_simtaru/presentation/widgets/forms/langkah6_form.dart';
import 'package:flutter_map_simtaru/presentation/widgets/forms/langkah7_form.dart';
import 'package:flutter_map_simtaru/presentation/widgets/other/show_snackbart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:loader_overlay/loader_overlay.dart';

final AutoDisposeStateProvider<LatLng> currLatLng = StateProvider.autoDispose<LatLng>((ref) => LatLng(0, 0));
final AutoDisposeStateProvider<List<File>> inputsFile =
    StateProvider.autoDispose<List<File>>((ref) => List.generate(10, (index) => File('')));

class PengajuanPage extends HookConsumerWidget {
  const PengajuanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);
    final currLatlangState = ref.watch(currLatLng);
    final currInputFileState = ref.watch(inputsFile);
    final user = ref.watch(userControllerProvider);
    final roleState = ref.watch(roleProvider);

    final useId = user.whenData((value) {
      if (value is UserSuccess) {
        return value.model.id;
      } else {
        return null;
      }
    });

    final List inputController = List.generate(17, (index) => useTextEditingController());

    // input default

    List<Step> steps() => [
          Step(
            title: Text(currentIndex.value == 0 ? 'Langkah 1' : ''),
            content: Langkah1Form(
              inputController: inputController,
            ),
            isActive: currentIndex.value >= 0,
          ),
          Step(
            title: Text(currentIndex.value == 1 ? 'Langkah 2' : ''),
            content: Langkah2Form(
              inputController: inputController,
            ),
            isActive: currentIndex.value >= 1,
          ),
          Step(
            title: Text(currentIndex.value == 2 ? 'Langkah 3' : ''),
            content: Langkah3Form(
              inputController: inputController,
            ),
            isActive: currentIndex.value >= 2,
          ),
          Step(
            title: Text(currentIndex.value == 3 ? 'Langkah 4' : ''),
            content: const Langkah4Form(),
            isActive: currentIndex.value >= 3,
          ),
          Step(
            title: Text(currentIndex.value == 4 ? 'Langkah 5' : ''),
            content: const Langkah5Form(),
            isActive: currentIndex.value >= 4,
          ),
          Step(
            title: Text(currentIndex.value == 5 ? 'Langkah 6' : ''),
            content: const Langkah6Form(),
            isActive: currentIndex.value >= 5,
          ),
          Step(
            title: Text(currentIndex.value == 6 ? 'Langkah 7' : ''),
            content: Langkah7Form(
              inputController: inputController,
            ),
            isActive: currentIndex.value >= 6,
          ),
        ];

    void submitFrom() async {
      context.loaderOverlay.show();
      try {
        var formData = FormData.fromMap({
          'user_id': useId.value,
          'nama_lengkap': inputController[0].text,
          'tempat_tanggal_lahir': inputController[1].text,
          'alamat': inputController[2].text,
          'no_hp': inputController[3].text,
          'pekerjaan': inputController[4].text,
          'no_identitas': inputController[5].text,
          'bertindak_atas_nama': inputController[6].text,
          'penggunaan_tanah_saat_dimohon': inputController[7].text,
          'luas_tanah_seluruhnya': inputController[8].text,
          'luas_tanah_yang_dimohon': inputController[9].text,
          'bukti_penguasaan_tanah': inputController[10].text,
          'letak_tanah': inputController[11].text,
          'rencana_penggunaan_tanah': inputController[12].text,
          'batas_sebelah_utara': inputController[13].text,
          'batas_sebelah_timur': inputController[14].text,
          'batas_sebelah_selatan': inputController[15].text,
          'batas_sebelah_barat': inputController[16].text,
          'titik_koordinat': '${ref.watch(currLatLng).latitude},${ref.watch(currLatLng).longitude}',
          'fotocopy_ktp': await MultipartFile.fromFile(currInputFileState[0].path),
          'fotocopy_sertifikat': await MultipartFile.fromFile(currInputFileState[1].path),
          'fotocopy_sppt_pbb': await MultipartFile.fromFile(currInputFileState[2].path),
          'fotocopy_npwp': await MultipartFile.fromFile(currInputFileState[3].path),
          'surat_persetujuan_tetangga': await MultipartFile.fromFile(currInputFileState[4].path),
          'gambar_rencana_pembangunan[]': await MultipartFile.fromFile(currInputFileState[5].path),
          'fotocopy_akte_pendirian_perusahaan': await MultipartFile.fromFile(currInputFileState[6].path),
          'set_lokasi_bangunan': await MultipartFile.fromFile(currInputFileState[7].path),
          'surat_pernyataan_force_majeur': await MultipartFile.fromFile(currInputFileState[8].path),
          'proposal': await MultipartFile.fromFile(currInputFileState[9].path),
        });
        print(formData.fields);
        final Dio dio = Dio();
        final url = Endpoints.baseURL + Endpoints.tambahPengajuan;
        await dio.post(
          url,
          data: formData,
        );
        if (roleState is Admin) {
          await ref.refresh(pengajuanControllerProvider.notifier).getPengajuan();
        } else {
          await ref.refresh(pengajuanUserControllerProvider.notifier).getPengajuan();
        }
        if (context.mounted) {
          context.loaderOverlay.hide();
          // ScaffoldMessenger.of(context).clearSnackBars();
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('Berhasil menambahkan pengajuan'),
          //   ),
          // );
          const RootRoute().go(context);
        }
      } on DioException catch (e) {
        if (context.mounted) {
          // ScaffoldMessenger.of(context).clearSnackBars();
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text("Terjadi kesalahan periksa kembali data anda")),
          // );
          if (e.response?.statusCode == 500) {
            AppSnackBar.show(context, "Terjadi kesalahan", AppColors.redColor);
          } else {
            AppSnackBar.show(context, "Terjadi kesalahan periksa kembali data anda", AppColors.redColor);
          }
        }
      } catch (e) {
        if (context.mounted) {
          AppSnackBar.show(context, "Terjadi kesalahan", AppColors.redColor);
        }
      } finally {
        if (context.mounted) {
          context.loaderOverlay.hide();
        }
      }

      context.loaderOverlay.hide();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          "Pengajuan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          ),
        ),
      ),
      body: Theme(
        data: ThemeData(
          fontFamily: "Poppins",
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          ),
        ),
        child: Stepper(
          elevation: 0,
          controlsBuilder: (context, details) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (currentIndex.value != 0)
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: const Text('Kembali'),
                      ),
                    if (currentIndex.value != steps().length - 1)
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 100,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                          ),
                          onPressed: details.onStepContinue,
                          child: const Text('Lanjut'),
                        ),
                      ),
                    if (currentIndex.value == steps().length - 1)
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 100,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                          ),
                          onPressed: () {
                            submitFrom();
                          },
                          child: const Text('Selesai'),
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
          type: StepperType.horizontal,
          steps: steps(),
          currentStep: currentIndex.value,
          onStepContinue: () {
            if (currentIndex.value < steps().length - 1) {
              switch (currentIndex.value) {
                case 0:
                  FocusScope.of(context).unfocus();
                  if (formPengajuanKey1.currentState!.validate()) {
                    currentIndex.value++;
                  }
                  break;
                case 1:
                  FocusScope.of(context).unfocus();
                  if (formPengajuanKey2.currentState!.validate()) {
                    currentIndex.value++;
                  }
                  break;
                case 2:
                  FocusScope.of(context).unfocus();
                  if (formPengajuanKey3.currentState!.validate()) {
                    currentIndex.value++;
                  }
                  break;
                case 3:
                  if (currLatlangState != LatLng(0, 0)) {
                    currentIndex.value++;
                  }
                  break;
                case 4:
                  FocusScope.of(context).unfocus();
                  if (currInputFileState[0].path != '' &&
                      currInputFileState[1].path != '' &&
                      currInputFileState[2].path != '' &&
                      currInputFileState[3].path != '' &&
                      currInputFileState[4].path != '') {
                    currentIndex.value++;
                  }
                  break;
                case 5:
                  FocusScope.of(context).unfocus();
                  if (currInputFileState[5].path != '' &&
                      currInputFileState[6].path != '' &&
                      currInputFileState[7].path != '' &&
                      currInputFileState[8].path != '' &&
                      currInputFileState[9].path != '') {
                    currentIndex.value++;
                  }
                  break;
                default:
                  FocusScope.of(context).unfocus();
                  currentIndex.value++;
              }
            }
          },
          onStepCancel: () {
            FocusScope.of(context).unfocus();
            if (currentIndex.value > 0) {
              currentIndex.value--;
            }
          },
        ),
      ),
    );
  }
}
