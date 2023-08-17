import 'package:flutter/material.dart';

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
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static ElevatedButtonThemeData elevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      minimumSize:
          MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    ),
  );

  static const InputDecoration inputDecoration = InputDecoration(
    contentPadding: EdgeInsets.all(10),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(3)),
    ),
  );
}
