import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class AppStyles {
  AppStyles._();

  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
  );

  static const TextStyle textButton = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const appBarTheme = AppBarTheme(
    backgroundColor: AppColors.primaryColor,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.whiteColor),
    titleTextStyle: TextStyle(
      color: AppColors.whiteColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );

  static ElevatedButtonThemeData elevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
      minimumSize:
          MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  );

  static const InputDecoration inputDecoration = InputDecoration(
    contentPadding: EdgeInsets.all(10),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.secondaryColor, width: 1.5),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.secondaryColor, width: 1.5),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  static const ButtonStyle textButtonStyle = ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    minimumSize: MaterialStatePropertyAll(Size.zero),
  );
}
