import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:things_dashboard/pages/splash/splash_controller.dart';

class Splash extends GetView<SplashController> {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: controller.animation!,
          alignment: Alignment.center,
          child: Image.asset(
            'assets/saipalogo.png',
            height: 150,
            width: 150,
          ),
        ),
      ),
    );
  }
}
