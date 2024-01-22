import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:things_dashboard/pages/home/home_controller.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('sdddddddddddds======= ${controller.deviceInformation}')
        ),
    );
  }
}
