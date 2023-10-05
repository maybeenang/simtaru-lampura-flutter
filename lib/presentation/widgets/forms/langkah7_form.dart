import 'package:flutter/material.dart';

class Langkah7Form extends StatelessWidget {
  const Langkah7Form({super.key, required this.inputController});

  final List inputController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: inputController.map((e) => Text(e.text)).toList()),
    );
  }
}
