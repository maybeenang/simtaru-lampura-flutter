import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:open_file/open_file.dart';

class DownloadService {
  DownloadService({required this.context});

  final BuildContext context;

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
    String _localPath = '/storage/emulated/0/Download/';

    if (!await Directory(_localPath).exists()) {
      await Directory(_localPath).create(recursive: true);
    }

    try {
      showSnackBar("Sedang mendownlad Dokumen", " ", () {});
      await FileDownloader.downloadFile(
        url: Endpoints.convertDownloadUrl(url),
        onDownloadError: (errorMessage) {
          print(errorMessage);
          ScaffoldMessenger.of(context).showSnackBar(snackbar("Gagal mendownload file", "Coba lagi", () {
            downloadFile(url: Endpoints.convertDownloadUrl(url));
          }));
          throw Exception(errorMessage);
        },
        onDownloadCompleted: (path) async {
          print("File Downloaded at $path");
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          try {
            OpenFile.open(path);
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
