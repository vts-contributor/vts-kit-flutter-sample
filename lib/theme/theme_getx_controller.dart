import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/theme/theme.dart';

class ThemeGetX extends GetxController {
  static String tag = 'ThemeGetX';

  Rx<ThemeData?> themeGetx = Rx<ThemeData?>(primaryTheme);
}
