import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

final isLoadingPetaProvider = StateProvider.autoDispose<bool>((ref) => false);

class PetaPage extends StatefulHookConsumerWidget {
  const PetaPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PetaPageState();
}

class _PetaPageState extends ConsumerState<PetaPage> {
  late WebViewController _controller;

  bool isLoading = false;
  bool isError = false;

  late SharedPreferences sharedPreferences;

  late String nip;
  late String password;

  final sharedPrefsNipKey = 'nip';
  final sharedPrefsPasswordKey = 'password';

  void getSharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();

    nip = sharedPreferences.getString(sharedPrefsNipKey) ?? "";
    password = sharedPreferences.getString(sharedPrefsPasswordKey) ?? "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSharedPrefs();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..scrollTo(0, 810)
      ..loadRequest(Uri.parse(Endpoints.peta))
      ..setBackgroundColor(AppColors.bgColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (change) {
            print("change ${change.url}");
            if (change.url!.contains("maps")) {
              setState(() {
                isLoading = true;
              });
            } else if (change.url!.contains("login")) {
              setState(() {
                isLoading = false;
              });
              _controller.runJavaScript("""
                document.querySelector("input[id=no_ktp]").value = "${nip.toString()}"
                document.querySelector("input[id=password]").value = "$password"
                document.querySelector("button[type=submit]").click()
                """);
            } else {
              setState(() {
                isLoading = false;
              });

              _controller.loadRequest(
                Uri.parse(Endpoints.peta),
              );
            }
          },
          onProgress: (progress) {
            print("progress $progress");
            if (progress == 100) {
              _controller.currentUrl().then((value) {
                print("value $value");
                setState(() {
                  isLoading = true;
                });
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }
          },
          onWebResourceError: (value) {
            print("value ${value.description}");
            setState(() {
              isLoading = false;
              isError = true;
            });
          },
          onPageFinished: (url) {
            print("ini url $url");
            if (url.contains("maps")) {
              setState(() {
                isLoading = true;
              });
            } else if (url.contains("login")) {
              setState(() {
                isLoading = false;
              });
              _controller.runJavaScript("""
                document.querySelector("input[id=no_ktp]").value = "${nip.toString()}"
                document.querySelector("input[id=password]").value = "$password"
                document.querySelector("button[type=submit]").click()
                """);
            } else {
              setState(() {
                isLoading = false;
              });

              _controller.loadRequest(
                Uri.parse(Endpoints.peta),
              );
            }
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        await _controller.reload();
      },
      child: Stack(
        children: [
          WebViewWidget(controller: _controller),
          !isLoading
              ? Container(
                  color: AppColors.whiteColor,
                  child: const Center(child: Padding(padding: EdgeInsets.all(20), child: LinearProgressIndicator())),
                )
              : const SizedBox.shrink(),
          isError
              ? Container(
                  color: AppColors.whiteColor,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Terjadi kesalahan"),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 200,
                          child: TextButton(
                            onPressed: () async {
                              setState(() {
                                isError = false;
                              });
                              await _controller.reload();
                            },
                            child: const Text("Muat ulang"),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    ));
  }
}
