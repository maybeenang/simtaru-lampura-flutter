import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user_utils.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_action_pengajuan.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomSheetCardUser extends HookConsumerWidget {
  const BottomSheetCardUser({super.key, this.actions, required this.user});

  final UserUtils user;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Action",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          ButtonActionPengajuan(
            label: "Edit User",
            icon: Icons.edit,
            color: AppColors.mapColorStatusChip[2],
            onTap: () {
              context.pop();
              AdminEditUserRoute(user).push(context);
            },
          ),
          const SizedBox(height: 10),
          ButtonActionPengajuan(
            label: "Hapus User",
            icon: Icons.delete,
            color: AppColors.redColor,
            onTap: () {},
          ),
          const SizedBox(height: 10),
          const Divider(
            endIndent: 10,
            indent: 10,
          ),
          const SizedBox(height: 10),
          ...actions ?? const [],
        ],
      ),
    );
  }
}
