import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_file/open_file.dart';

class InputUploadFile extends HookConsumerWidget {
  const InputUploadFile({super.key, required this.title, required this.pengajuan, required this.fileController});

  final String title;
  final Pengajuan pengajuan;
  final ValueNotifier<File> fileController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final namaFile = useState('');
    final file = useState<PlatformFile?>(null);

    void openFileExplorer() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpeg', 'jpg'],
      );

      if (result != null) {
        fileController.value = File(result.files.single.path!);
        // fileController.text = result.files.single.path!;
        namaFile.value = result.files.single.name;
        file.value = result.files.first;
        // ref.read(inputsFile.notifier).state[index] = File(result.files.single.path!);
        // print(ref.read(inputsFile.notifier).state[index]);
      }
    }

    void openFile(PlatformFile file) {
      OpenFile.open(file.path);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Text(title),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppDouble.paddingInside, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.greyColor),
          ),
          child: Row(
            children: [
              namaFile.value != ''
                  ? Container(
                      width: 100,
                      child: GestureDetector(
                        onTap: () {
                          if (namaFile.value != '') {
                            openFile(file.value!);
                          }
                        },
                        child: Text(
                          namaFile.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  : const Text(
                      "Belum ada file",
                      style: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: 12,
                      ),
                    ),
              const Spacer(),
              ButtonIcon(
                icon: Icons.edit,
                onTap: () {
                  openFileExplorer();
                },
                bgColor: Colors.amber[700],
              ),
              const SizedBox(width: 10),
              ButtonIcon(
                icon: Icons.delete,
                onTap: () {
                  namaFile.value = '';
                  file.value = null;
                  fileController.value = File('');
                },
                bgColor: AppColors.redColor,
              ),
            ],
          ),
        )
      ],
    );
  }
}
