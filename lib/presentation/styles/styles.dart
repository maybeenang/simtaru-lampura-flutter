import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';

class AppStyles {
  AppStyles._();

  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
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
    filled: true,
    fillColor: AppColors.whiteColor,
    hintStyle: TextStyle(color: AppColors.greyColor),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.borderColor, width: 1.5),
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.borderColor, width: 1.5),
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
    labelStyle: TextStyle(
      color: AppColors.greyColor,
      fontSize: 14,
    ),
  );

  static const ButtonStyle textButtonStyle = ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    minimumSize: MaterialStatePropertyAll(Size.zero),
  );

  static BoxShadow boxShadowStyle = BoxShadow(
    color: AppColors.borderColor.withOpacity(0.9),
    blurRadius: 10,
    offset: const Offset(0, 4),
  );

  static BoxShadow appBarBoxShadowStyle = BoxShadow(
    color: AppColors.primaryColor.withOpacity(0.5),
    blurRadius: 10,
    offset: const Offset(0, 5),
  );
}
