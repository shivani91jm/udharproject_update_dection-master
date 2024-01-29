import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenSizeUtil {
  /// init in the MaterialApp
  static  BuildContext? context=Get.context;

  static get screenWidth => MediaQuery.of(context!).size.width;

  static get screenHeight => MediaQuery.of(context!).size.height;
}
