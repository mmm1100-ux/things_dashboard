import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:things_dashboard/core/glob.dart';


class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {


      final controller = Get.find<GlobeController>();
      Map<String, dynamic> devInfo = {};
       List devInfoDetail = [];
      Future deviceInformation() async {
    // if (box.read('id') != null) {
    print('@100');
    try {
      print('@200');

      final res = await controller.tbClient?.get(
          '/api/plugins/telemetry/DEVICE/b625fc90-a245-11ee-bff6-9dd69ba07d8c/values/timeseries?keys=iD%2CpR%2CcD%2CvS%2CtC%2CdN&startTs=0&endTs=1999999999999&orderBy=DESC');
      print('@300 $res');
      devInfo = res?.data;
      print('devInfo: ' + devInfo.toString());
      devInfo.forEach((key, value) {
        if (key != null) {
          devInfoDetail.add({'name': key, 'val': value[0]["value"]});
        }
      });

      print('@400 $devInfoDetail');

      update();
      // devList = RxList.from(res?.data["data"]) ;
    } catch (err) {
      rethrow;
    }
    //  }
  }
    }