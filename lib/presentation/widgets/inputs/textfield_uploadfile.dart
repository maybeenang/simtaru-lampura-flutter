import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class TextFieldUploadFile extends StatelessWidget {
  const TextFieldUploadFile({super.key, required this.labelText});

  final String labelText;

  @override
  Widget build(BuildContext context) {
    Future<void> _openFileExplorer() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        print(file);
      }
    }

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(labelText),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Expanded(
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(color: Colors.white, width: 2)),
                  hintText: 'File belum diupload',
                  contentPadding: EdgeInsets.all(10.0),
                ),
              ),
            ),
            const SizedBox(width: 5),
            ElevatedButton(
              onPressed: () {
                _openFileExplorer();
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text("Pilih File"),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
