import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/custom_safe_area.dart';

class SearchPengajuanPage extends StatelessWidget {
  const SearchPengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomSafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text("Search Pengajuan"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
