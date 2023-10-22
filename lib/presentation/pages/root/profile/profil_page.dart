import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/domain/entity/role/role.dart';
import 'package:flutter_map_simtaru/presentation/controllers/roles/role_provider.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user_controller.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/loading/profile_card_loading.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/profile/admin_menu_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/profile/user_menu_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/profile_card.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_appbar_fitur.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilPage extends ConsumerWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userControllerProvider);
    final roleState = ref.watch(roleProvider);

    return RefreshIndicator(
      onRefresh: () async {
        await ref.refresh(userControllerProvider.notifier).getProfile();
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const CustomAppBarFitur(
                  title: "Profile",
                  bgColor: AppColors.primaryColor,
                  labelColor: AppColors.whiteColor,
                ),
                Stack(
                  children: [
                    Container(
                      color: AppColors.primaryColor,
                      child: const SizedBox(
                        width: double.infinity,
                        height: 50,
                      ),
                    ),
                    userState.when(
                      data: (data) {
                        if (data is UserSuccess) {
                          return ProfileCard(data: data);
                        } else {
                          return const ProfileCardLoading();
                        }
                      },
                      error: (error, stackTrace) {
                        return const ProfileCardLoading();
                      },
                      loading: () {
                        return const ProfileCardLoading();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const UserMenuProfileCard(),
                const SizedBox(height: 20),
                if (roleState is Admin) const AdminMenuProfileCard(),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
