import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
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
    );
  }

  void showSnackBar(String word, String? label, void Function()? onPressed) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackbar(word, label!, onPressed));
  }

  Future<void> downloadFile({required String url}) async {
    var permission = await Permission.storage.request();

    if (permission.isDenied) {
      await Permission.storage.request();
    }

    var permssion13 = await Permission.manageExternalStorage.request();

    if (permssion13.isDenied) {
      await Permission.manageExternalStorage.request();
    }

    // if (permission.isDenied || permssion13.isDenied) {
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

    final Response response = await dio.get(
      Endpoints.convertDownloadUrl(url),
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

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
      return;
    }

    try {
      showSnackBar("Sedang mendownlad Dokumen", " ", () {});

      await FileDownloader.downloadFile(
        notificationType: NotificationType.progressOnly,
        url: Endpoints.convertDownloadUrl(url),
        onDownloadError: (errorMessage) {
          print(errorMessage);
          ScaffoldMessenger.of(context).showSnackBar(snackbar("Gagal mendownload file", "Coba lagi", () {
            downloadFile(url: Endpoints.convertDownloadUrl(url));
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
          } catch (e) {
            print(e.toString());
          }
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        snackbar(
          "Gagal mendownload file",
          "Coba lagi",
          () {
            downloadFile(url: Endpoints.convertDownloadUrl(url));
          },
        ),
      );
    }
  }
}
