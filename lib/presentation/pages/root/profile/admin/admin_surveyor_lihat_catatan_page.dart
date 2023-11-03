import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminSurveyorLihatCatatanPage extends HookConsumerWidget {
  const AdminSurveyorLihatCatatanPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Lihat Catatan"),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
