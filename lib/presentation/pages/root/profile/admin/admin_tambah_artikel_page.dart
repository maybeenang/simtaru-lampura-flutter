import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/controllers/artikel/artikel_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/form/form_state.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AdminTambahArtikelPage extends HookConsumerWidget {
  const AdminTambahArtikelPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = List.generate(2, (index) => useTextEditingController());

    void handleSubmit() async {
      FocusScope.of(context).unfocus();
      if (formTambahArtikelKey.currentState!.validate()) {
        context.loaderOverlay.show();

        final data = {
          "judul": inputController[0].text,
          "isi": inputController[1].text,
        };
        final result = await ref.read(artikelControllerProvider.notifier).createArtikel(data);

        if (result == "Berhasil Tambah Artikel") {
          if (context.mounted) {
            context.loaderOverlay.hide();
            Flushbar(
              message: "Berhasil Tambah Artikel",
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
              message: "Gagal Tambah Artikel",
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
        title: const Text("Admin Tambah Artikel"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Tambah Artikel",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: formTambahArtikelKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Judul Artikel",
                      ),
                      controller: inputController[0],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Judul artikel tidak boleh kosong";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      maxLines: 10, //or null
                      decoration: const InputDecoration(
                        labelText: "Isi Artikel",
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
              const SizedBox(height: 20),
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
