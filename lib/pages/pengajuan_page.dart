import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/forms/langkah1_form.dart';
import 'package:flutter_map_simtaru/forms/langkah2_form.dart';
import 'package:flutter_map_simtaru/forms/langkah3_form.dart';
import 'package:flutter_map_simtaru/forms/langkah4_form.dart';
import 'package:go_router/go_router.dart';

class PengajuanPage extends StatefulWidget {
  const PengajuanPage({super.key});

  @override
  State<PengajuanPage> createState() => _PengajuanPageState();
}

class _PengajuanPageState extends State<PengajuanPage> {
  int currentIndex = 0;

  List<Step> steps() => [
        Step(
          title: Text(currentIndex == 0 ? 'Step 1' : ''),
          content: const Langkah1Form(),
          isActive: currentIndex >= 0,
        ),
        Step(
          title: Text(currentIndex == 1 ? 'Step 2' : ''),
          content: const Langkah2Form(),
          isActive: currentIndex >= 1,
        ),
        Step(
          title: Text(currentIndex == 2 ? 'Step 3' : ''),
          content: const Langkah3Form(),
          isActive: currentIndex >= 2,
        ),
        Step(
          title: Text(currentIndex == 3 ? 'Step 4' : ''),
          content: const Langkah4Form(),
          isActive: currentIndex >= 3,
        ),
        Step(
          title: Text(currentIndex == 4 ? 'Step 5' : ''),
          content: const Text('World!'),
          isActive: currentIndex >= 4,
        ),
        Step(
          title: Text(currentIndex == 5 ? 'Step 6' : ''),
          content: const Text('World!'),
          isActive: currentIndex >= 5,
        ),
        Step(
          title: Text(currentIndex == 6 ? 'Step 7' : ''),
          content: const Text('World!'),
          isActive: currentIndex >= 6,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengajuan"),
      ),
      body: Theme(
        data: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          ),
        ),
        child: Stepper(
          elevation: 0,
          type: StepperType.horizontal,
          steps: steps(),
          currentStep: currentIndex,
          onStepContinue: () {
            if (currentIndex < steps().length - 1) {
              setState(() {
                currentIndex++;
              });
            }
          },
          onStepCancel: () => setState(() {
            if (currentIndex > 0) {
              currentIndex--;
            } else {
              context.pop();
            }
          }),
        ),
      ),
    );
  }
}
