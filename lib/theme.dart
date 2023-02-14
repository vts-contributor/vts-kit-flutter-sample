import 'package:flutter/material.dart';
import 'package:sample/constants/colors.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.colorF0F5F9,
    fontFamily: "SVN-Gotham",
    appBarTheme: appBarTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: AppColors.colorF0F5F9,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    //toolbarTextStyle: TextStyle(color: FoodHubColors.color0B0C0C, fontSize: 18),
    // systemOverlayStyle: SystemUiOverlayStyle.light,
  );
}
