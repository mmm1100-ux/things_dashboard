import 'dart:developer';

import 'package:get/get.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class GlobeController extends GetxController {
  ThingsboardClient? tbClient;
  @override
  void onInit() async {
    tbClient = ThingsboardClient('http://iot.saipacorp.com:8080');
    await tbClient!.login(
      LoginRequest('amiri_t@saipacorp.com', 'S@ma123456'),
    );

    super.onInit();
  }

  String? customerNumber;
  String? customerId;

  Future getCustomerByTitle(String customerNum) async {
    customerNumber = customerNum;
    var response = await tbClient!.get(
      '/api/tenant/customers?customerTitle=$customerNum',
    );

    customerId = response.data["id"]["id"];
    log("customer id $customerId");
  }

  String? selectedDeviceId;
}

