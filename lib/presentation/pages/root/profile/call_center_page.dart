import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/call_center.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_profile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CallCenterPage extends HookConsumerWidget {
  const CallCenterPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pusat Bantuan"),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: const Column(
              children: [
                ButtonProfile(
                  label: CallCenter.telp,
                  icon: Icons.phone,
                  // onTap: () {},
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                ButtonProfile(
                  label: CallCenter.telp2,
                  icon: Icons.phone,
                  // onTap: () {},
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                ButtonProfile(
                  label: CallCenter.email,
                  icon: Icons.email,
                  // onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
