import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:things_dashboard/core/glob.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  AnimationController? animController;
  Animation<double>? animation;
  GlobeController? globeController;

  @override
  void onInit() async {
    super.onInit();
    globeController = Get.find<GlobeController>();
    animController = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this, value: 0.1);
    animation =
        CurvedAnimation(parent: animController!, curve: Curves.decelerate);

    final box = GetStorage();
    bool isDarkMode = box.read('darkMode') ?? false;
    if (isDarkMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.changeThemeMode(
          ThemeMode.dark,
        );
      });
    }

    animController!.forward();

    Timer(const Duration(milliseconds: 2000), () {
      Get.delete<SplashController>();

       Get.offAllNamed('/home');
    });
  }

  @override
  void onClose() {
    animController?.dispose();
    super.onClose();
  }
}
