import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminSurveyorTambahCatatanPage extends HookConsumerWidget {
  const AdminSurveyorTambahCatatanPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Catatan'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Catatan",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Simpan",
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
