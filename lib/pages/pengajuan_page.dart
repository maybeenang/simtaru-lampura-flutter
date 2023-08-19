import 'package:flutter/material.dart';

class PengajuanPage extends StatefulWidget {
  const PengajuanPage({super.key});

  @override
  State<PengajuanPage> createState() => _PengajuanPageState();
}

class _PengajuanPageState extends State<PengajuanPage> {
  int currentIndex = 0;

  List<Step> steps() => [
        Step(
          title: const Text('Step 1'),
          content: const Text('Hello!'),
          isActive: currentIndex >= 0,
        ),
        Step(
          title: const Text('Step 2'),
          content: const Text('World!'),
          isActive: currentIndex >= 1,
        ),
        Step(
          title: const Text('Step 3'),
          content: const Text('World!'),
          isActive: currentIndex >= 2,
        ),
        Step(
          title: const Text('Step 4'),
          content: const Text('World!'),
          isActive: currentIndex >= 3,
        ),
        Step(
          title: const Text('Step 5'),
          content: const Text('World!'),
          isActive: currentIndex >= 4,
        ),
        Step(
          title: const Text('Step 6'),
          content: const Text('World!'),
          isActive: currentIndex >= 5,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengajuan"),
      ),
      body: Stepper(
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
          }
        }),
      ),
    );
  }
}
