import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

final isLoadingPetaProvider = StateProvider.autoDispose<bool>((ref) => false);

class PetaPage extends StatefulHookConsumerWidget {
  const PetaPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PetaPageState();
}

class _PetaPageState extends ConsumerState<PetaPage> {
  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..scrollTo(0, 810)
      ..loadRequest(Uri.parse(Endpoints.peta))
      ..setBackgroundColor(AppColors.bgColor);
    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
