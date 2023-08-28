import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/cards/carousel_pengajuan_card.dart';
import 'package:flutter_map_simtaru/components/custom_appbar_fitur.dart';
import 'package:flutter_map_simtaru/components/item_pengajuan.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:go_router/go_router.dart';

class OverviewPengajuanPage extends StatelessWidget {
  const OverviewPengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.bgColor,
        width: double.infinity,
        child: Column(
          children: [
            const CustomAppBarFitur(
              title: "Pengajuan",
              bgColor: AppColors.primaryColor,
              labelColor: AppColors.whiteColor,
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
                  child: Material(
                    elevation: 3,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Future.delayed(
                          const Duration(milliseconds: 300),
                          () {
                            context.push('/search_pengajuan');
                          },
                        );
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.search,
                              color: AppColors.greyColor,
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: const Text(
                                "Cari pengajuan",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.greyColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const CarouselPengajuanCard(),
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.all(10),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Material(
            //         child: InkWell(
            //           onTap: () {},
            //           child: Ink(
            //             width: 50,
            //             height: 50,
            //             decoration: BoxDecoration(
            //               color: AppColors.primaryColor,
            //               borderRadius: BorderRadius.circular(5),
            //             ),
            //             child: const Icon(
            //               Icons.search,
            //               color: Colors.white,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: 5,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                return const ItemPengajuan();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
