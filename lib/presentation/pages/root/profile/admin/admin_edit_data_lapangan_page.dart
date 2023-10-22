import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/inputs/textfield_common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AdminEditDataLapanganPage extends HookConsumerWidget {
  const AdminEditDataLapanganPage({super.key, required this.pengajuan});

  final Pengajuan pengajuan;

  Widget CustomDivider({required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.secondaryColor,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = List.generate(32, (index) => useTextEditingController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Data Lapangan"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Text(
              "Kesesuaian Data Lapangan atas nama ${pengajuan.nama_lengkap}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),
            Form(
              // key: formEditPengajuanKey,
              child: Column(
                children: [
                  TextFieldCommon(
                    controller: inputController[0],
                    labelText: "Tanggal peninjauajan Lokasi",
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: AppColors.primaryColor,
                              ),
                              dialogBackgroundColor: AppColors.whiteColor,
                            ),
                            child: child!,
                          );
                        },
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2015),
                        // DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        inputController[0].text = formattedDate;
                      }
                    },
                    initialValue: pengajuan.tanggal_peninjauan_lokasi,
                  ),
                  const SizedBox(height: 10),
                  CustomDivider(text: "Letak Tanah"),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[1],
                    labelText: "Desa",
                    initialValue: pengajuan.desa,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[2],
                    labelText: "Kecamatan",
                    initialValue: pengajuan.kecamatan,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[3],
                    labelText: "Batas sebelah utara",
                    initialValue: pengajuan.batas_sebelah_utara,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[4],
                    labelText: "Batas sebelah timur",
                    initialValue: pengajuan.batas_sebelah_timur,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[5],
                    labelText: "Batas sebelah selatan",
                    initialValue: pengajuan.batas_sebelah_selatan,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[6],
                    labelText: "Batas sebelah barat",
                    initialValue: pengajuan.batas_sebelah_barat,
                  ),
                  const SizedBox(height: 10),
                  CustomDivider(text: "Letak Dimohon"),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[7],
                    labelText: "Letak tanah eksisting",
                    initialValue: pengajuan.penggunaan_tanah_saat_dimohon,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[8],
                    labelText: "Topografi tanah",
                    initialValue: pengajuan.topografi_tanah,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[9],
                    labelText: "Rencana penggunaan tanah",
                    initialValue: pengajuan.rencana_penggunaan_tanah,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[10],
                    labelText: "Kesuburan tanah",
                    initialValue: pengajuan.kesuburan_tanah,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[11],
                    labelText: "Sarana Irigasi atau Sumurbor",
                    initialValue: pengajuan.sarana_irigasi_atau_sumurbor,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[12],
                    labelText: "Jarak Bangunan Dengan Sungai",
                    initialValue: pengajuan.jarak_bangunan_dengan_sungai,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[13],
                    labelText: "Jarak Bangunan Dengan Jalan",
                    initialValue: pengajuan.jarak_bangunan_dengan_jalan,
                  ),
                  const SizedBox(height: 10),
                  CustomDivider(text: "Status Tanah"),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[14],
                    labelText: "Status kepemilikan",
                    initialValue: pengajuan.status_kepemilikan,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[15],
                    labelText: "Bukti Penguasaan Tanah",
                    initialValue: pengajuan.bukti_penguasaan_tanah,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[16],
                    labelText: "Luas Tanah Seluruhnya",
                    initialValue: pengajuan.luas_tanah_seluruhnya,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[17],
                    labelText: "Luas Tanah Yang Dimohon",
                    initialValue: pengajuan.luas_tanah_yang_dimohon,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[18],
                    labelText: "Luas Tanah Yang Disetujui",
                    initialValue: pengajuan.luas_tanah_yang_disetujui,
                  ),
                  const SizedBox(height: 10),
                  CustomDivider(text: "Keputusan"),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[19],
                    labelText: "Kesesuaian Dengan Rencana Tata Ruang Wilayah",
                    initialValue: pengajuan.kesesuaian_rencana,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[20],
                    labelText: "Hubungan Pemohon Dengan Tanah Tersebut",
                    initialValue: pengajuan.hubungan_pemohon_dengan_tanah,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[21],
                    labelText: "Kesesuaian Dengan Keadaan Fisik Tanah",
                    initialValue: pengajuan.kesesuaian_dengan_keadaan_fisik_tanah,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[22],
                    labelText: "Tanah Yang Dimohon Fisiknya Berupa",
                    initialValue: pengajuan.tanah_yang_dimohon_fisiknya,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[23],
                    labelText: "Jarak Dari Permukiman Terdekat",
                    initialValue: pengajuan.jarak_dari_pemukiman_terdekat,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[24],
                    labelText: "Pertimbangan/Analisis Lainnya",
                    initialValue: pengajuan.pertimbangan,
                  ),
                  const SizedBox(height: 10),
                  CustomDivider(text: "Intensitas Pemanfaatan Ruang"),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[25],
                    labelText: "Luas Bangunan",
                    initialValue: pengajuan.luas_bangunan,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[26],
                    labelText: "Tinggi Bangunan",
                    initialValue: pengajuan.tinggi_bangunan,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[27],
                    labelText: "Koefisien Dasar Bangunan",
                    initialValue: pengajuan.kdb,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[28],
                    labelText: "Koefisien Lantai Bangunan",
                    initialValue: pengajuan.klb,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[29],
                    labelText: "Koefisien Dasar Hijau",
                    initialValue: pengajuan.kdh,
                  ),
                  const SizedBox(height: 10),
                  TextFieldCommon(
                    controller: inputController[30],
                    labelText: "Garis Sempadan Bangunan",
                    initialValue: pengajuan.gsb,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Simpan",
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      )),
    );
  }
}
