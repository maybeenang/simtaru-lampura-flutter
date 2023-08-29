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
            const SizedBox(height: 20),
            // Container(
            //   alignment: Alignment.centerRight,
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   width: double.infinity,
            //   child: Material(
            //     child: InkWell(
            //       onTap: () {},
            //       child: Ink(
            //         width: 200,
            //         padding: const EdgeInsets.symmetric(
            //           horizontal: 20,
            //           vertical: 10,
            //         ),
            //         decoration: BoxDecoration(
            //           color: AppColors.primaryColor,
            //           borderRadius: BorderRadius.circular(50),
            //         ),
            //         child: const Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             Icon(
            //               Icons.add,
            //               color: AppColors.whiteColor,
            //             ),
            //             SizedBox(width: 10),
            //             Text(
            //               "Tambah Pengajuan",
            //               style: TextStyle(color: AppColors.whiteColor),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 20),
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
