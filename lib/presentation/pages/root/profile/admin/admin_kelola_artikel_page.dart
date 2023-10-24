import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminKelolaArtikelPage extends HookConsumerWidget {
  const AdminKelolaArtikelPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Kelola Artikel"),
      ),
      body: const Center(
        child: Text("Admin Kelola Artikel"),
      ),
    );
  }
}
