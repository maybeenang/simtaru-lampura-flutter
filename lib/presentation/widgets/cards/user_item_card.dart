import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            AppStyles.boxShadowStyle,
          ],
        ),
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
              child:
                  userUtil?.profile_photo_url != null ? tryBuildImage(userUtil!.profile_photo_url) : const SizedBox(),
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
    );
  }
}
