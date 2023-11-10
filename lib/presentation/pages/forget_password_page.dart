import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late WebViewController _controller;

  bool isLoading = false;
  bool isError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(Endpoints.forgotPassword))
      ..setBackgroundColor(AppColors.bgColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            print("progress $progress");
            if (progress == 100) {
              setState(() {
                isLoading = true;
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }
          },
          onWebResourceError: (value) {
            setState(() {
              isLoading = false;
              isError = true;
            });
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
