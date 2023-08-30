import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/custom_safe_area.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:flutter_map_simtaru/constants/image.dart';
import 'package:go_router/go_router.dart';

class DetailBeritaPage extends StatelessWidget {
  const DetailBeritaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColors.bgColor,
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
                      color: AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    "Berita",
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: Image.asset(
                Images.berita,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: const Column(
                children: [
                  Text(
                    "Lorem ipsum dolor sit amet, consecte tur adipiscing elit",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      height: 1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "12/12/2021",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.remove_red_eye_outlined,
                        size: 16,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "60",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Lorem ipsum dolor sit amet, consecte tur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consecte tur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    style: TextStyle(
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
