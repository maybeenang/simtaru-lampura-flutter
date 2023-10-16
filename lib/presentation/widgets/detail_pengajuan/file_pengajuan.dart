import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_file/open_file.dart';

class FilePengajuan extends HookConsumerWidget {
  const FilePengajuan({super.key, required this.labelText, required this.file});

  final String labelText;
  final File file;

  void openFile(File file) {
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          labelText,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  openFile(file);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    file.path.split('/').last,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ButtonIcon(
              icon: Icons.remove_red_eye_rounded,
              onTap: () {
                openFile(file);
              },
            ),
          ],
        ),
      ],
    );
  }
}
