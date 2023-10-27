// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:loader_overlay/loader_overlay.dart';
// import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadService {
  DownloadService({required this.context, required this.dio, required this.token});

  final BuildContext context;
  final Dio dio;
  final String token;

  SnackBar snackbar(String word, String label, void Function()? onPressed, {Color color = Colors.red}) {
    return SnackBar(
      content: Text(word, style: const TextStyle(color: Colors.white, fontSize: 12)),
      action: SnackBarAction(
        label: label,
        onPressed: onPressed!,
      ),
      backgroundColor: color,
      // duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
    );
  }

  void showSnackBar(String word, String? label, void Function()? onPressed) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackbar(word, label!, onPressed));
  }

  Future<void> downloadFile({required String url}) async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;

    if (deviceInfo.version.sdkInt <= 28) {
      final status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          snackbar(
            "Izin akses penyimpanan ditolak",
            "Coba lagi",
            () {
              downloadFile(url: Endpoints.convertDownloadUrl(url));
            },
          ),
        );
        return;
      }
    }

    // if (deviceInfo.version.sdkInt > 32) {
    //   permissionStatus = await Permission.photos.request().isGranted;
    // } else {
    //   permissionStatus = await Permission.storage.request().isGranted;
    // }

    // var permssion13 = await Permission.manageExternalStorage.request();

    // if (permssion13.isDenied) {
    //   await Permission.manageExternalStorage.request();
    // }

    // if (!permissionStatus || permssion13.isDenied) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     snackbar(
    //       "Izin akses penyimpanan ditolak",
    //       "Coba lagi",
    //       () {
    //         downloadFile(url: Endpoints.convertDownloadUrl(url));
    //       },
    //     ),
    //   );
    //   return;
    // }

    // check directory is exist
    String _localPath = Directory("/storage/emulated/0/Download/").path;
    print(_localPath);

    if (!await Directory(_localPath).exists()) {
      await Directory(_localPath).create(recursive: true);
    }

    context.loaderOverlay.show();
    Response response;

    try {
      // await File(_localPath).create(recursive: true);
      response = await dio.get(
        Endpoints.convertDownloadUrl(url),
      );
    } catch (e) {
      print(e.toString());
      context.loaderOverlay.hide();

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        snackbar(
          "Gagal membuka file",
          "",
          () {
            // downloadFile(url: Endpoints.convertDownloadUrl(url));
          },
        ),
      );
      return;
    }

    // create file name
    String fileExtension = response.headers.value("content-type")!.split("/").last;

    if (fileExtension != "pdf" && fileExtension != "jpg" && fileExtension != "png" && fileExtension != "jpeg") {
      print("MASUK");
      print(fileExtension);
      // print(e.toString());
      context.loaderOverlay.hide();

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        snackbar(
          "Gagal mendownload file",
          "",
          () {
            // downloadFile(url: Endpoints.convertDownloadUrl(url));
          },
        ),
      );
      return;
    }

    // String fileName = "${url.split("/").last}.$fileExtension";
    String fileId = url.split("/")[(url.split("/").length - 3)];
    String fileId2 = url.split("/")[(url.split("/").length - 2)];
    // fileName = "${fileId}_$fileName";
    String fileName2 = "${fileId}_${url.split("/").last}_$fileId2";

    // check file is exist
    // print(File(_localPath + fileName).existsSync());
    // if (File(_localPath + fileName).existsSync()) {
    //   await OpenFile.open(File(_localPath + fileName).path);

    //   OpenResult result = await OpenFile.open(File(_localPath + fileName).path);

    //   print(result.message);
    //   context.loaderOverlay.hide();
    //   return;
    // }

    var taskId;

    try {
      taskId = await FlutterDownloader.enqueue(
        url: Endpoints.convertDownloadUrl(url),
        headers: {
          "Authorization": "Bearer $token",
          "ngrok-skip-browser-warning": "69420",
        }, // optional: header send with url (auth token etc)
        savedDir: _localPath,
        allowCellular: true,
        saveInPublicStorage: true,
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
        fileName: fileName2,
      );

      print("KONTOOOLLL $taskId");

      context.loaderOverlay.hide();

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        snackbar(
          "Sedang mendownload file, silihakan cek notifikasi",
          "",
          () {
            // downloadFile(url: Endpoints.convertDownloadUrl(url));
          },
          color: Colors.green,
        ),
      );

      // await FileDownloader.downloadFile(
      //   headers: {
      //     "Authorization": "Bearer $token",
      //     "ngrok-skip-browser-warning": "69420",
      //   },
      //   url: Endpoints.convertDownloadUrl(url),
      //   onDownloadError: (errorMessage) {
      //     // print("KONTOL $errorMessage");
      //     context.loaderOverlay.hide();

      //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //     ScaffoldMessenger.of(context).showSnackBar(snackbar("Gagal membuka file", "", () {
      //       // downloadFile(url: url);
      //     }));
      //     throw Exception(errorMessage);
      //   },
      //   name: fileName,
      //   downloadDestination: DownloadDestinations.publicDownloads,
      //   onDownloadCompleted: (path) async {
      //     print("File Downloaded at $path");
      //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //     try {
      //       context.loaderOverlay.hide();
      //       await OpenFile.open(path);
      //     } catch (e) {
      //       context.loaderOverlay.hide();

      //       print(e.toString());
      //     }
      //   },
      // );
      // context.loaderOverlay.hide();
    } catch (e) {
      print(e.toString());
      context.loaderOverlay.hide();

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        snackbar(
          "Gagal membuka file",
          "",
          () {
            // downloadFile(url: Endpoints.convertDownloadUrl(url));
          },
        ),
      );
    }
  }
}
