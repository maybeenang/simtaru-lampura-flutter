import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/domain/entity/role/role.dart';
import 'package:flutter_map_simtaru/domain/entity/user/user.dart';
import 'package:flutter_map_simtaru/presentation/controllers/dio/dio_provider.dart';
import 'package:flutter_map_simtaru/presentation/controllers/roles/role_provider.dart';
import 'package:flutter_map_simtaru/presentation/controllers/user_controller.dart';
import 'package:flutter_map_simtaru/presentation/styles/styles.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/item_pengajuan_card.dart';
import 'package:flutter_map_simtaru/presentation/widgets/cards/loading/item_pengajuan_loading.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPengajuanPage extends HookConsumerWidget {
  const SearchPengajuanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dio = ref.watch(dioProvider);
    final page = useState(1);
    final searchInput = useTextEditingController();
    final roleState = ref.watch(roleProvider);
    final userId = ref.watch(userControllerProvider).maybeWhen(
          data: (data) {
            if (data is UserSuccess) {
              return data.model.id;
            } else {
              return 0;
            }
          },
          orElse: () => 0,
        );

    final isLoading = useState(false);

    final scrollController = ScrollController();

    final searchPengajuanItem = useState([]);

    Future searchPengajuan(String input) async {
      page.value = 1;
      print("searchPengajuan");
      isLoading.value = true;
      // final Dio dio = Dio();
      if (userId == 0) {
        return;
      }
      String query;
      if (roleState is Admin) {
        query = "?searchName=$input&page=${page.value}";
      } else if (roleState is AdminVerifBerkas) {
        query = "?searchName=$input&searchStatus=2&page=${page.value}";
      } else if (roleState is AdminVerifLapangan) {
        query = "?searchName=$input&searchStatus=3&page=${page.value}";
      } else if (roleState is AdminUploadScanSurat) {
        query = "?searchName=$input&searchStatus=11&page=${page.value}";
      } else if (roleState is Surveyor) {
        query = "?searchName=$input&searchStatus=12&page=${page.value}";
      } else {
        query = "?searchUserId=$userId&searchName=$input&page=${page.value}";
      }
      try {
        final response = await dio.get(
          Endpoints.baseURL + Endpoints.seluruhPengajuan + query,
        );
        final List<Pengajuan> pengajuan = (response.data['data'] as List).map((e) => Pengajuan.fromJson(e)).toList();
        searchPengajuanItem.value = pengajuan;
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
        searchPengajuanItem.value = [];
        return Future.error(e.toString());
      }
    }

    Future loadMore(String input) async {
      print("loadMore");
      if (userId == 0) {
        return;
      }
      String query;
      if (roleState is Admin) {
        query = "?searchName=$input&page=${page.value}";
      } else if (roleState is AdminVerifBerkas) {
        query = "?searchName=$input&searchStatus=2&page=${page.value}";
      } else if (roleState is AdminVerifLapangan) {
        query = "?searchName=$input&searchStatus=3&page=${page.value}";
      } else if (roleState is AdminUploadScanSurat) {
        query = "?searchName=$input&searchStatus=11&page=${page.value}";
      } else if (roleState is Surveyor) {
        query = "?searchName=$input&searchStatus=12&page=${page.value}";
      } else {
        query = "?searchUserId=$userId&searchName=$input&page=${page.value}";
      }
      try {
        final response = await dio.get(
          Endpoints.baseURL + Endpoints.seluruhPengajuan + query,
        );

        if (response.data['data'] == null || response.data['data'].isEmpty) {
          page.value--;
          return;
        }

        final List<Pengajuan> pengajuan = (response.data['data'] as List).map((e) => Pengajuan.fromJson(e)).toList();
        searchPengajuanItem.value = [...searchPengajuanItem.value, ...pengajuan];
      } catch (e, s) {
        print(s.toString());
        return Future.error(e.toString());
      }
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        page.value++;
        loadMore(
          searchInput.text,
        );
      }
    });

    return CustomSafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      "Cari Pengajuan",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    color: AppColors.primaryColor,
                    child: const SizedBox(
                      width: double.infinity,
                      height: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          AppStyles.boxShadowStyle,
                        ],
                      ),
                      child: TextField(
                        onSubmitted: (value) {
                          if (value.isEmpty) {
                            return;
                          }
                          searchPengajuan(value);
                        },
                        controller: searchInput,
                        autofocus: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.whiteColor,
                          hintText: "Cari berdasarkan nama",
                          contentPadding: const EdgeInsets.all(10),
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(),
              ),
              isLoading.value
                  ? ListView.separated(
                      padding: const EdgeInsetsDirectional.all(10),
                      itemBuilder: (context, index) {
                        return const ItemPengajuanLoading();
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    )
                  : searchPengajuanItem.value.isEmpty
                      ? const Center(
                          child: Text("Tidak ada data"),
                        )
                      : ListView.separated(
                          padding: const EdgeInsetsDirectional.all(10),
                          itemBuilder: (context, index) {
                            return ItemPengajuanCard(pengajuan: searchPengajuanItem.value[index]);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemCount: searchPengajuanItem.value.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
