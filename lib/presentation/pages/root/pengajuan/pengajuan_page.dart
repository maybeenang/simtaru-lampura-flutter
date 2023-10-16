import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/presentation/controllers/form/form_state.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/widgets/forms/langkah1_form.dart';
import 'package:flutter_map_simtaru/presentation/widgets/forms/langkah2_form.dart';
import 'package:flutter_map_simtaru/presentation/widgets/forms/langkah3_form.dart';
import 'package:flutter_map_simtaru/presentation/widgets/forms/langkah4_form.dart';
import 'package:flutter_map_simtaru/presentation/widgets/forms/langkah5_form.dart';
import 'package:flutter_map_simtaru/presentation/widgets/forms/langkah6_form.dart';
import 'package:flutter_map_simtaru/presentation/widgets/forms/langkah7_form.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

final AutoDisposeStateProvider<LatLng> currLatLng = StateProvider.autoDispose<LatLng>((ref) => LatLng(0, 0));
final AutoDisposeStateProvider<List<File>> inputsFile =
    StateProvider.autoDispose<List<File>>((ref) => List.generate(10, (index) => File('')));

class PengajuanPage extends HookConsumerWidget {
  const PengajuanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);
    final currLatlangState = ref.watch(currLatLng);
    final currInputFileState = ref.watch(inputsFile);

    final List inputController = List.generate(17, (index) => useTextEditingController());

    // input default

    List<Step> steps() => [
          Step(
            title: Text(currentIndex.value == 0 ? 'Langkah 1' : ''),
            content: Langkah1Form(
              inputController: inputController,
            ),
            isActive: currentIndex.value >= 0,
          ),
          Step(
            title: Text(currentIndex.value == 1 ? 'Langkah 2' : ''),
            content: Langkah2Form(
              inputController: inputController,
            ),
            isActive: currentIndex.value >= 1,
          ),
          Step(
            title: Text(currentIndex.value == 2 ? 'Langkah 3' : ''),
            content: Langkah3Form(
              inputController: inputController,
            ),
            isActive: currentIndex.value >= 2,
          ),
          Step(
            title: Text(currentIndex.value == 3 ? 'Langkah 4' : ''),
            content: const Langkah4Form(),
            isActive: currentIndex.value >= 3,
          ),
          Step(
            title: Text(currentIndex.value == 4 ? 'Langkah 5' : ''),
            content: Langkah5Form(),
            isActive: currentIndex.value >= 4,
          ),
          Step(
            title: Text(currentIndex.value == 5 ? 'Langkah 6' : ''),
            content: const Langkah6Form(),
            isActive: currentIndex.value >= 5,
          ),
          Step(
            title: Text(currentIndex.value == 6 ? 'Langkah 7' : ''),
            content: Langkah7Form(
              inputController: inputController,
            ),
            isActive: currentIndex.value >= 6,
          ),
        ];

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
                    if (currentIndex.value != 0)
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: const Text('Kembali'),
                      ),
                    if (currentIndex.value != steps().length - 1)
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
                    if (currentIndex.value == steps().length - 1)
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 100,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                          ),
                          onPressed: () => const RootRoute().go(context),
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
          currentStep: currentIndex.value,
          onStepContinue: () {
            if (currentIndex.value < steps().length - 1) {
              switch (currentIndex.value) {
                case 0:
                  FocusScope.of(context).unfocus();
                  if (formPengajuanKey1.currentState!.validate()) {
                    currentIndex.value++;
                  }
                  break;
                case 1:
                  FocusScope.of(context).unfocus();
                  if (formPengajuanKey2.currentState!.validate()) {
                    currentIndex.value++;
                  }
                  break;
                case 2:
                  FocusScope.of(context).unfocus();
                  if (formPengajuanKey3.currentState!.validate()) {
                    currentIndex.value++;
                  }
                  break;
                case 3:
                  if (currLatlangState != LatLng(0, 0)) {
                    currentIndex.value++;
                  }
                  break;
                case 4:
                  FocusScope.of(context).unfocus();
                  if (currInputFileState[0].path != '' &&
                      currInputFileState[1].path != '' &&
                      currInputFileState[2].path != '' &&
                      currInputFileState[3].path != '' &&
                      currInputFileState[4].path != '') {
                    currentIndex.value++;
                  }
                  break;
                case 5:
                  FocusScope.of(context).unfocus();
                  if (currInputFileState[5].path != '' &&
                      currInputFileState[6].path != '' &&
                      currInputFileState[7].path != '' &&
                      currInputFileState[8].path != '' &&
                      currInputFileState[9].path != '') {
                    currentIndex.value++;
                  }
                  break;
                default:
                  FocusScope.of(context).unfocus();
                  currentIndex.value++;
              }
            }
          },
          onStepCancel: () {
            FocusScope.of(context).unfocus();
            if (currentIndex.value > 0) {
              currentIndex.value--;
            }
          },
        ),
      ),
    );
  }
}
