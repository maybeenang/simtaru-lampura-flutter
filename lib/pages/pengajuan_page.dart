import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/forms/langkah1_form.dart';
import 'package:flutter_map_simtaru/forms/langkah2_form.dart';
import 'package:flutter_map_simtaru/forms/langkah3_form.dart';
import 'package:flutter_map_simtaru/forms/langkah4_form.dart';
import 'package:flutter_map_simtaru/forms/langkah5_form.dart';
import 'package:flutter_map_simtaru/forms/langkah6_form.dart';
import 'package:flutter_map_simtaru/forms/langkah7_form.dart';
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
          title: Text(currentIndex == 0 ? 'Langkah 1' : ''),
          content: const Langkah1Form(),
          isActive: currentIndex >= 0,
        ),
        Step(
          title: Text(currentIndex == 1 ? 'Langkah 2' : ''),
          content: const Langkah2Form(),
          isActive: currentIndex >= 1,
        ),
        Step(
          title: Text(currentIndex == 2 ? 'Langkah 3' : ''),
          content: const Langkah3Form(),
          isActive: currentIndex >= 2,
        ),
        Step(
          title: Text(currentIndex == 3 ? 'Langkah 4' : ''),
          content: const Langkah4Form(),
          isActive: currentIndex >= 3,
        ),
        Step(
          title: Text(currentIndex == 4 ? 'Langkah 5' : ''),
          content: const Langkah5Form(),
          isActive: currentIndex >= 4,
        ),
        Step(
          title: Text(currentIndex == 5 ? 'Langkah 6' : ''),
          content: const Langkah6Form(),
          isActive: currentIndex >= 5,
        ),
        Step(
          title: Text(currentIndex == 6 ? 'Langkah 7' : ''),
          content: const Langkah7Form(),
          isActive: currentIndex >= 6,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          "Pengajuan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          ),
        ),
      ),
      body: Theme(
        data: ThemeData(
          fontFamily: "Poppins",
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          ),
        ),
        child: Stepper(
          elevation: 0,
          controlsBuilder: (context, details) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (currentIndex != 0)
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: const Text('Kembali'),
                      ),
                    if (currentIndex != steps().length - 1)
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 100,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                          ),
                          onPressed: details.onStepContinue,
                          child: const Text('Lanjut'),
                        ),
                      ),
                    if (currentIndex == steps().length - 1)
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 100,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                          ),
                          onPressed: () => context.go('/'),
                          child: const Text('Selesai'),
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
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
