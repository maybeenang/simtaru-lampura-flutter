import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/artikel/artikel.dart';
import 'package:flutter_map_simtaru/presentation/controllers/artikel/artikel_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/form/form_state.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AdminEditArtikelPage extends HookConsumerWidget {
  const AdminEditArtikelPage({super.key, required this.artikel});

  final Artikel artikel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = List.generate(2, (index) => useTextEditingController());

    useEffect(() {
      inputController[0].text = artikel.judul;
      inputController[1].text = artikel.isi;

      return () {};
    }, []);

    void handleSubmit() async {
      FocusScope.of(context).unfocus();
      if (formEditArtikelKey.currentState!.validate()) {
        context.loaderOverlay.show();

        final data = {
          "judul": inputController[0].text,
          "isi": inputController[1].text,
        };
        final result = await ref.read(artikelControllerProvider.notifier).editArtikel(data, artikel.id.toString());

        if (result == "Berhasil Edit Artikel") {
          if (context.mounted) {
            context.loaderOverlay.hide();
            Flushbar(
              message: "Berhasil Edit Artikel",
              backgroundColor: AppColors.greenColor,
              duration: const Duration(seconds: 1),
              flushbarPosition: FlushbarPosition.TOP,
              flushbarStyle: FlushbarStyle.FLOATING,
              animationDuration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
              isDismissible: true,
              shouldIconPulse: false,
              icon: const Icon(
                Icons.check,
                color: AppColors.whiteColor,
              ),
            ).show(context).then((value) => context.pop());
          }
        } else {
          if (context.mounted) {
            context.loaderOverlay.hide();
            Flushbar(
              message: "Gagal Edit Artikel",
              backgroundColor: AppColors.redColor,
              duration: const Duration(seconds: 3),
              flushbarPosition: FlushbarPosition.TOP,
              flushbarStyle: FlushbarStyle.FLOATING,
              animationDuration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
              isDismissible: true,
              shouldIconPulse: false,
              icon: const Icon(
                Icons.close,
                color: AppColors.whiteColor,
              ),
            ).show(context);
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Edit Artikel"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Form(
                key: formEditArtikelKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Judul Artikel",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        fillColor: AppColors.whiteColor,
                        filled: true,
                      ),
                      controller: inputController[0],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Judul artikel tidak boleh kosong";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Isi Artikel",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      maxLines: 10, //or null
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        fillColor: AppColors.whiteColor,
                        filled: true,
                      ),
                      controller: inputController[1],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Isi artikel tidak boleh kosong";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  handleSubmit();
                },
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
      ),
    );
  }
}
