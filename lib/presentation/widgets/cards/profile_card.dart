import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/data/constants/double.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user_utils.dart';
import 'package:flutter_map_simtaru/presentation/routes/routes.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.data});

  final User data;

  UserUtils? get user => data.mapOrNull(
        success: (value) => value.model,
        error: (value) => null,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: AppDouble.paddingOutside,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppDouble.borderRadius),
        boxShadow: [
          AppStyles.boxShadowStyle,
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Future.delayed(
              const Duration(milliseconds: 300),
              () {
                const EditProfileRoute().go(context);
              },
            );
          },
          child: Ink(
            padding: const EdgeInsets.all(AppDouble.paddingInside),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.greyColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: SvgPicture.network(
                    user!.profile_photo_url,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        user!.name.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        user!.email.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
