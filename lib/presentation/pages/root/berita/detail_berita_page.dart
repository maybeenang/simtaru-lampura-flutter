import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/artikel/artikel.dart';
import 'package:flutter_map_simtaru/presentation/widgets/customs/custom_safe_area.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DetailBeritaPage extends StatelessWidget {
  const DetailBeritaPage({super.key, required this.artikel});

  final Artikel artikel;

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      color: AppColors.bgColor,
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
                    "Artikel",
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
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: BorderDirectional(
                        start: BorderSide(
                          color: Colors.black54,
                          width: 6.0,
                        ),
                      ),
                    ),
                    padding: const EdgeInsetsDirectional.only(start: 15, top: 15, bottom: 15),
                    child: Column(
                      children: [
                        Text(
                          artikel.judul,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        DateFormat('yyyy-MM-dd').format(artikel.created_at),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  Text(
                    artikel.isi,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
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
