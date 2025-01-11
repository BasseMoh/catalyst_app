import 'dart:math';
import 'package:get/get.dart';

extension ScreenSize on double {
  double get r {
    return min(Get.height, Get.width) * this;
  }

  double get w {
    return Get.width * this;
  }

  double get h {
    return Get.height * this;
  }
}
