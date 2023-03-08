import 'package:flutter/material.dart';
import 'package:sample/constants/colors.dart';
import 'package:sample/theme/theme_button.dart';

ThemeData primaryTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.kPrimaryColor,
  fontFamily: "SVN-Gotham",
  buttonTheme: buttonThemeData,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.kPrimaryColor,
  ),
);

ThemeData secondaryTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.kSecondaryColor,
  fontFamily: "SVN-Gotham",
  buttonTheme: secondaryButtonThemeData,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.kSecondaryColor,
  ),
);
