import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminRevisiBerkasPage extends ConsumerWidget {
  const AdminRevisiBerkasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text("Admin Revisi Berkas Page"),
      ),
    );
  }
}
