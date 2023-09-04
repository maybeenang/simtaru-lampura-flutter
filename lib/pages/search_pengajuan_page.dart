import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/custom_safe_area.dart';
import 'package:flutter_map_simtaru/components/item_pengajuan.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:flutter_map_simtaru/styles/styles.dart';
import 'package:go_router/go_router.dart';

class SearchPengajuanPage extends StatefulWidget {
  const SearchPengajuanPage({super.key});

  @override
  State<SearchPengajuanPage> createState() => _SearchPengajuanPageState();
}

class _SearchPengajuanPageState extends State<SearchPengajuanPage> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SingleChildScrollView(
          child: Column(
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
                      "Pengajuan",
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
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Filter",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ChoiceChip(
                      label: Text('Item ${index + 1} '),
                      selectedColor: AppColors.primaryColor,
                      labelStyle: TextStyle(
                        color: _value == index
                            ? AppColors.whiteColor
                            : AppColors.greyColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      showCheckmark: false,
                      selected: _value == index,
                      onSelected: (bool selected) {
                        setState(
                          () {
                            _value = (selected ? index : null)!;
                          },
                        );
                      },
                    );
                    // return Material(
                    //   borderRadius: BorderRadius.circular(50),
                    //   color: Colors.transparent,
                    //   child: InkWell(
                    //     onTap: () {},
                    //     child: Ink(
                    //       decoration: BoxDecoration(
                    //         color: index == 0
                    //             ? AppColors.primaryColor
                    //             : AppColors.whiteColor,
                    //         border: Border.all(
                    //           width: 2,
                    //           color: AppColors.primaryColor,
                    //         ),
                    //         borderRadius: BorderRadius.circular(50),
                    //       ),
                    //       padding: const EdgeInsets.symmetric(
                    //         horizontal: 20,
                    //         vertical: 10,
                    //       ),
                    //       child: Container(
                    //         alignment: Alignment.center,
                    //         child: Text(
                    //           "Kat ${index + 1}",
                    //           style: TextStyle(
                    //             color: index == 0
                    //                 ? AppColors.whiteColor
                    //                 : AppColors.primaryColor,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(),
              ),
              ListView.separated(
                padding: const EdgeInsetsDirectional.all(10),
                itemBuilder: (context, index) {
                  return const ItemPengajuan();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: 5,
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
