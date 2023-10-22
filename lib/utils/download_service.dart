// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadService {
  DownloadService({required this.context});

  final BuildContext context;
  final Dio dio = Dio();

  SnackBar snackbar(String word, String label, void Function()? onPressed) {
    return SnackBar(
      content: Text(word),
      action: SnackBarAction(
        label: label,
        onPressed: onPressed!,
      ),
      backgroundColor: Colors.red,
    );
  }

  void showSnackBar(String word, String? label, void Function()? onPressed) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackbar(word, label!, onPressed));
  }

  Future<void> downloadFile({required String url}) async {
    bool permissionStatus;
    final deviceInfo = await DeviceInfoPlugin().androidInfo;

    if (deviceInfo.version.sdkInt > 32) {
      permissionStatus = await Permission.photos.request().isGranted;
    } else {
      permissionStatus = await Permission.storage.request().isGranted;
    }

    var permssion13 = await Permission.manageExternalStorage.request();

    if (permssion13.isDenied) {
      await Permission.manageExternalStorage.request();
    }

    if (!permissionStatus || permssion13.isDenied) {
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

    // check directory is exist
    String _localPath = Directory("/storage/emulated/0/Download/").path;
    print(_localPath);

    if (!await Directory(_localPath).exists()) {
      await Directory(_localPath).create(recursive: true);
    }

    context.loaderOverlay.show();
    Response response;

    try {
      await File(_localPath + "test.txt").create(recursive: true);
      response = await dio.get(
        Endpoints.convertDownloadUrl(url),
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
    } catch (e) {
      print(e.toString());
      context.loaderOverlay.hide();
      return;
    }

    // create file name
    String fileExtension = response.headers.value("content-type")!.split("/").last;

    String fileName = "${url.split("/").last}.$fileExtension";
    String fileId = url.split("/")[(url.split("/").length - 2)];
    fileName = "${fileId}_$fileName";

    // check file is exist
    print(File(_localPath + fileName).existsSync());
    if (File(_localPath + fileName).existsSync()) {
      await OpenFile.open(File(_localPath + fileName).path);

      OpenResult result = await OpenFile.open(File(_localPath + fileName).path);

      print(result.message);
      context.loaderOverlay.hide();
      return;
    }

    try {
      await FileDownloader.downloadFile(
        url: Endpoints.convertDownloadUrl(url),
        onDownloadError: (errorMessage) {
          context.loaderOverlay.hide();

          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackbar("Gagal membuka file", "", () {
            downloadFile(url: url);
          }));
          throw Exception(errorMessage);
        },
        name: fileName,
        downloadDestination: DownloadDestinations.publicDownloads,
        onDownloadCompleted: (path) async {
          print("File Downloaded at $path");
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          try {
            await OpenFile.open(path);
            context.loaderOverlay.hide();
          } catch (e) {
            context.loaderOverlay.hide();

            print(e.toString());
          }
        },
      );
    } catch (e) {
      context.loaderOverlay.hide();

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        snackbar(
          "Gagal membuka file",
          "",
          () {
            downloadFile(url: Endpoints.convertDownloadUrl(url));
          },
        ),
      );
    }
  }
}
