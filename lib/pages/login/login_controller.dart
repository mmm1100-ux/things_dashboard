import 'dart:async';
import 'dart:convert'; // New import
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:things_dashboard/core/glob.dart';
import 'package:things_dashboard/service/http_service.dart';
import 'package:things_dashboard/service/http_service_impl.dart';
import 'package:thingsboard_client/thingsboard_client.dart';
import 'package:http/http.dart' as http; // New import

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GlobeController? globeController;
   late HttpService httpService;

  @override
  void onInit() async {
    httpService = Get.put(HttpServiceImpl());
    httpService.init();
    numberController.addListener(() {
      update();
    });
    numberFocusNode.requestFocus();
    globeController = Get.find<GlobeController>();

    verifyController.addListener(() async {
      if (verifyController.text.length == 4) {
        await verifyCode(); // Verify code when input reaches 4 digits
      }
    });
    timerController = TimerController(this);

    super.onInit();
  }

  TextEditingController numberController = TextEditingController();
  TextEditingController verifyController = TextEditingController();
  FocusNode numberFocusNode = FocusNode();
  FocusNode verifyFocusNode = FocusNode();
  bool verification = false;
  bool resendVerification = false;

  changeVerification(bool value) {
    verification = value;
    if (value) {
      Future.delayed(const Duration(milliseconds: 500), () {
        changeResendVerification(false);
        timerController!.reset();
        timerController!.start();
        verifyFocusNode.requestFocus();
      });
    }
    update();
  }

  changeResendVerification(bool value) {
    resendVerification = value;
    update();
  }

  TimerController? timerController;
  TimerStyle timerStyle = TimerStyle.expanding_sector;
  TimerProgressIndicatorDirection progressIndicatorDirection =
      TimerProgressIndicatorDirection.clockwise;
  TimerProgressTextCountDirection progressTextCountDirection =
      TimerProgressTextCountDirection.count_down;

  void timerValueChangeListener(Duration timeElapsed) {}

  void handleTimerOnStart() {
    log("timer has just started");
  }

  void handleTimerOnEnd() {
    log("timer has ended");
    changeResendVerification(true);
  }

  sendCodeRequest() async {
    try {
      Map<String, dynamic> body = {
        "mobileNo": int.tryParse(numberController.text) ?? 0
      };
      var response = await http.post(
        Uri.parse('https://dashboardapp.saipacorp.com/api/api/account/SCCAppSend'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      log("response sms ${response.body}");
      if (response.statusCode == 200) {
        changeVerification(true);
      } else {
        // Handle failure
      }
    } catch (e) {
      log("response sms error $e");
    }
  }



  verifyCode() async {
  if (verifyController.text.length == 4) {
    try {
      Map<String, dynamic> body = {
        "mobileNo": int.tryParse(numberController.text) ?? 0,
        "pinCode": int.tryParse(verifyController.text) ?? 0
      };

      var response = await http.post(
        Uri.parse('https://dashboardapp.saipacorp.com/api/api/account/SCCAppCheck'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      log("response sms ${response.body}");

      bool responseSuccess =true;

      if (response.statusCode == 200 && responseSuccess) {
  goToDashboard();
      } else {
        Get.snackbar('خطا', 'کد وارد شده صحیح نمیباشد');
        // Show error
      }
    } catch (e) {
      log("response sms error $e");
    }
  }
}


  bool isLoadingDashboard = false;

  goToDashboard() async {
  isLoadingDashboard = true;
  print('vrooooooooooooooooooooooooooooooooooood');
  update();
  try {
    await globeController!.tbClient!.post(
      '/api/customer',
      data: {
        "title": numberController.text.toString(),
      },
    );
    globeController!
        .getCustomerByTitle(numberController.text.toString())
        .then((value) {
      final box = GetStorage();
      box.write('title', numberController.text.toString());

      Get.offNamed('/dashboard');
    });
  } on ThingsboardError catch (e) {
    if (e.errorCode == 31) {
      globeController!
          .getCustomerByTitle(numberController.text.toString())
          .then((value) {
        final box = GetStorage();
        box.write('title', numberController.text.toString());
        Get.offNamed('/dashboard');
      });

      log(
        'customer res ${e.message}',
      );
    }
  }

  isLoadingDashboard = false;
  update();
}
}














// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:sccapp/core/globe_controller.dart';
// import 'package:sccapp/service/http_service.dart';
// import 'package:sccapp/service/http_service_impl.dart';
// import 'package:simple_timer/simple_timer.dart';
// import 'package:thingsboard_client/thingsboard_client.dart';

// class LoginController extends GetxController
//     with GetSingleTickerProviderStateMixin {
//   GlobeController? globeController;
//   late HttpService httpService;

//   @override
//   void onInit() async {
//     httpService = Get.put(HttpServiceImpl());
//     httpService.init();
//     numberController.addListener(() {
//       update();
//     });
//     numberFocusNode.requestFocus();

//     globeController = Get.find<GlobeController>();

//     //if need verify

//     verifyController.addListener(() async {
//       if (verifyController.text.length == 4) {
//         //requset dovom baraye check kardan code ersali

//         //   try {
//         //     var res = await httpService!.getRequest(
//         //         'http://iot.saipacorp.com:8080/api/plugins/telemetry/DEVICE/a2e587a0-1581-11ee-80e4-313cd7ea402a/keys/timeseries');
//         //     log("response sms ${res}");
//         //     if (1 == 1) {
//         //       //check if code is correct
//         goToDashboard();
//         //   } else {}
//         // } catch (e) {
//         //   log("response sms error $e");
//         // }
//       }
//     });
//     timerController = TimerController(this);

//     super.onInit();
//   }

//   TextEditingController numberController = TextEditingController();
//   TextEditingController verifyController = TextEditingController();
//   FocusNode numberFocusNode = FocusNode();
//   FocusNode verifyFocusNode = FocusNode();
//   bool verification = false;
//   bool resendVerification = false;

//   changeVerification(bool value) {
//     verification = value;
//     if (value) {
//       Future.delayed(const Duration(milliseconds: 500), () {
//         changeResendVerification(false);
//         timerController!.reset();
//         timerController!.start();
//         verifyFocusNode.requestFocus();
//       });
//     }
//     update();
//   }

//   changeResendVerification(bool value) {
//     resendVerification = value;
//     update();
//   }

//   TimerController? timerController;
//   TimerStyle timerStyle = TimerStyle.expanding_sector;
//   TimerProgressIndicatorDirection progressIndicatorDirection =
//       TimerProgressIndicatorDirection.clockwise;
//   TimerProgressTextCountDirection progressTextCountDirection =
//       TimerProgressTextCountDirection.count_down;

//   void timerValueChangeListener(Duration timeElapsed) {}

//   void handleTimerOnStart() {
//     log("timer has just started");
//   }

//   void handleTimerOnEnd() {
//     log("timer has ended");
//     changeResendVerification(true);
//   }

//   sendCodeRequest() async {
//     try {
//       //request ersal code taeed
//       var res = await httpService.getRequest(
//           'http://iot.saipacorp.com:8080/api/plugins/telemetry/DEVICE/2df4c737-a8a3-4d62-be02-cc9d35462ae8/keys/timeseries');
//       log("response sms ${res}");
//       if (1 == 1) {
//         //check if code is correct
//         // Get.offNamed('/dashboard');
//       } else {}
//     } catch (e) {
//       log("response sms error $e");
//     }
//   }

//   bool isLoadingDashboard = false;

//   goToDashboard() async {
//     isLoadingDashboard = true;
//     update();

//     // log('isAuthenticated=${tbClient.isAuthenticated()}');

//     // log('authUser: ${tbClient.getAuthUser()}');
//     // log('authUser: ${tbClient.getJwtToken()}');

//     try {
//       await globeController!.tbClient!.post(
//         '/api/customer',
//         data: {
//           "title": numberController.text.toString(),
//         },
//       );
//       globeController!
//           .getCustomerByTitle(numberController.text.toString())
//           .then((value) {
//         final box = GetStorage();
//         box.write('title', numberController.text.toString());

//         Get.offNamed('/dashboard');
//       });
//     } on ThingsboardError catch (e) {
//       if (e.errorCode == 31) {
//         globeController!
//             .getCustomerByTitle(numberController.text.toString())
//             .then((value) {
//           final box = GetStorage();
//           box.write('title', numberController.text.toString());
//           Get.offNamed('/dashboard');
//         });

//         log(
//           'customer res ${e.message}',
//         );
//       }
//     }

//     // var response = await tbClient.get(
//     //   '/api/plugins/telemetry/DEVICE/ba12d230-ffe6-11ed-9af4-4bbe01e1ef68/keys/timeseries',
//     // );
//     // log(
//     //   'telemetry res ${response.data}',
//     // );

//     isLoadingDashboard = false;
//     update();
//   }
// }
