import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/status_pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/controllers/status_pengajuan_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InputDropDownMenu extends HookConsumerWidget {
  const InputDropDownMenu({super.key, required this.title, required this.pengajuan, required this.inputController});

  final String title;
  final Pengajuan pengajuan;
  final ValueNotifier<int> inputController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusState = ref.watch(statusPengajuanControllerProvider);

    final List<StatusPengajuan> itemMenu = statusState.maybeWhen(
      orElse: () {
        return [];
      },
      data: (data) => data,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const Text(
          "Pastikan anda memilih status yang benar!",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red),
        ),
        const SizedBox(height: 30),
        Text(title),
        DropdownButtonFormField(
          isExpanded: true,
          value: pengajuan.status_id,
          items: [
            const DropdownMenuItem(value: null, child: Text("Pilih")),
            ...itemMenu.map((e) => DropdownMenuItem(value: e.id, child: Text(e.jenis_status))),
          ],
          onChanged: (value) {
            if (value != null) {
              inputController.value = value;
            }
          },
        )
      ],
    );
  }
}
