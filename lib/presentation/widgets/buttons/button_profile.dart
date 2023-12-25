import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/notif_pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/controllers/dio/dio_provider.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_jumlah_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonProfile extends HookConsumerWidget {
  const ButtonProfile({super.key, this.label = "Button", this.icon = Icons.add, this.onTap, this.color = AppColors.blackColor, this.isNotif = false});

  final String label;
  final IconData? icon;
  final Function()? onTap;
  final Color? color;
  final bool? isNotif;

  Future<NotifPengajuan> getNotif(Dio dio) async {
    try {
      var query = "/";
      switch (label) {
        case "Pengajuan Ditolak":
          query += "1";
          break;
        case "Verifikasi Berkas":
          query += "2";
          break;
        case "Verifikasi Lapangan":
          query += "3";
          break;
        case "Upload Scan Surat":
          query += "11";
          break;
        case "Surat Rekomendasi":
          query += "12";
          break;
        default:
      }

      final Uri uri = Uri.parse(Endpoints.baseURL + Endpoints.pengajuanJumlah + query);
      // final Dio dio = Dio();
      final Response response = await dio.get(
        uri.toString(),
      );

      final NotifPengajuan notifPengajuan = NotifPengajuan.fromJson(response.data);

      return notifPengajuan;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dio = ref.watch(dioProvider);
    final notif = useState<NotifPengajuan?>(null);
    final jumlahPengajuanState = ref.watch(pengajuanJumlahControllerProvider);

    useEffect(() {
      if (label != "Seluruh Pengajuan") {
        getNotif(dio).then((value) => notif.value = value);
      }

      return;
    }, []);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.5,
              //   child: Text(
              //     label,
              //     style: TextStyle(color: color),
              //     maxLines: 3,
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // ),

              Text(label, style: TextStyle(color: color)),
              const Spacer(),
              if (isNotif!)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.redColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    label == "Seluruh Pengajuan"
                        ? jumlahPengajuanState.maybeWhen(orElse: () => null, data: (value) => value)?.Seluruh.toString() ?? "0"
                        : notif.value?.Total.toString() ?? "0",
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
