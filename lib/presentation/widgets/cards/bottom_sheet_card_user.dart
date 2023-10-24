import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user_utils.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_action_pengajuan.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomSheetCardUser extends StatefulHookConsumerWidget {
  const BottomSheetCardUser({super.key, required this.user, this.actions});

  final UserUtils user;

  final List<Widget>? actions;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomSheetCardUserState();
}

class _BottomSheetCardUserState extends ConsumerState<BottomSheetCardUser> {
  @override
  Widget build(BuildContext context) {
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
              AdminEditUserRoute(widget.user).push(context);
            },
          ),
          const SizedBox(height: 10),
          const Divider(
            endIndent: 10,
            indent: 10,
          ),
          const SizedBox(height: 10),
          ...widget.actions ?? const [],
        ],
      ),
    );
  }
}
