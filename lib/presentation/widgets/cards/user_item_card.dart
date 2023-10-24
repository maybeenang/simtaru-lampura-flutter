import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user/admin_user_controller.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/buttons/button_action_pengajuan.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/bottom_sheet_card_user.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class UserItemCard extends HookConsumerWidget {
  const UserItemCard({super.key, required this.user});

  final User user;

  Widget tryBuildImage(String url) {
    return SvgPicture.network(
      url,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userUtil = user.when(
      success: (data) => data,
      error: (error) => null,
    );

    Future deleteUser(String id) async {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: "Hapus User",
        text: "Apakah anda yakin ingin menghapus user ini?",
        cancelBtnText: "Batal",
        confirmBtnText: "Ya",
        confirmBtnColor: AppColors.redColor,
        onConfirmBtnTap: () async {
          Navigator.pop(context);
          context.loaderOverlay.show();
          final result = await ref.read(adminUserControllerProvider.notifier).deleteUser(id);
          result.when(
            success: (data) {
              context.loaderOverlay.hide();
              Flushbar(
                message: "Berhasil Hapus User",
                backgroundColor: AppColors.greenColor,
                duration: const Duration(seconds: 2),
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
              ).show(context);
            },
            error: (error) {
              context.loaderOverlay.hide();
              Flushbar(
                message: error.toString(),
                backgroundColor: AppColors.redColor,
                duration: const Duration(seconds: 2),
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
            },
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 100,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            AppStyles.boxShadowStyle,
          ],
        ),
        child: Material(
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => BottomSheetCardUser(
                  user: userUtil!,
                  actions: [
                    ButtonActionPengajuan(
                      label: "Hapus User",
                      icon: Icons.delete,
                      color: AppColors.redColor,
                      onTap: () {
                        context.pop();
                        deleteUser(userUtil.id.toString());
                      },
                    ),
                  ],
                ),
              );
            },
            child: Row(
              children: [
                const SizedBox(width: 20),
                Container(
                  clipBehavior: Clip.antiAlias,
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: userUtil?.profile_photo_url != null
                      ? tryBuildImage(userUtil!.profile_photo_url)
                      : const SizedBox(),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userUtil?.name ?? "User",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        userUtil?.email ?? "email",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
