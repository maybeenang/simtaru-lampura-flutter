import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_file/open_file.dart';

class TextFieldUploadFile extends HookConsumerWidget {
  const TextFieldUploadFile({super.key, required this.labelText});

  final String labelText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final namaFile = useState('');
    final file = useState<PlatformFile?>(null);

    void openFileExplorer() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
      );

      if (result != null) {
        namaFile.value = result.files.single.path!;
        file.value = result.files.first;
      }
    }

    void _openFile(PlatformFile file) {
      OpenFile.open(file.path);
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: namaFile.value == '' ? AppColors.whiteColor : null,
                  border: namaFile.value == '' ? Border.all(color: AppColors.greyColor) : null,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  namaFile.value == '' ? 'Belum ada file yang dipilih' : namaFile.value.toString().split('/').last,
                ),
              ),
            ),
            const SizedBox(width: 5),
            namaFile.value == ''
                ? ElevatedButton(
                    onPressed: () async {
                      openFileExplorer();
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    child: const Text("Pilih File"),
                  )
                : Row(
                    children: [
                      ButtonIcon(
                        icon: Icons.remove_red_eye,
                        onTap: () {
                          _openFile(file.value!);
                        },
                      ),
                      const SizedBox(width: 5),
                      ButtonIcon(
                        icon: Icons.edit,
                        onTap: () async {
                          openFileExplorer();
                        },
                        bgColor: AppColors.greenColor,
                      ),
                      const SizedBox(width: 5),
                      ButtonIcon(
                        icon: Icons.close,
                        onTap: () {
                          namaFile.value = '';
                          file.value = null;
                        },
                        bgColor: AppColors.actionColor,
                      ),
                    ],
                  ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
