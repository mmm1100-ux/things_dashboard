import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:things_dashboard/pages/login/login_controller.dart';

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  color: Color(0xffE8AA42),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Image.asset(
                          'assets/saipalogo.png',
                          height: 100,
                          width: 100,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  color: Colors.white,
                ),
              )
            ],
          ),
          Positioned.fill(
            top: 150,
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      // color: const Color(0xffF8F1F1),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          child: GetBuilder<LoginController>(builder: (_) {
                            return !controller.verification
                                ? Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'ورود / ثبت نام',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'شماره موبایل خود را وارد کنید',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 20,
                                                offset: const Offset(0, 5),
                                              ),
                                            ],
                                          ),
                                          child: TextFormField(
                                            controller:
                                                controller.numberController,
                                            focusNode:
                                                controller.numberFocusNode,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  11),
                                            ],
                                            decoration: InputDecoration(
                                              labelText: 'شماره موبایل',
                                              filled: true,
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20, 10),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade400),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2.0),
                                              ),
                                            ),
                                            validator: (val) {
                                              if (val!.isEmpty) {
                                                return 'شماره همراه را وارد نمایید';
                                              } else if (!RegExp(r"^\d+$")
                                                  .hasMatch(val)) {
                                                return 'شماره همراه را صحیح وارد نمایید';
                                              }
                                              return null;
                                            },
                                            textAlign: TextAlign.center,
                                            // onChanged: (value) {
                                            //   if (value.startsWith('0')) {
                                            //     controller.numberController
                                            //         .text = value.substring(1);
                                            //   }
                                            // },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(child:
                                                GetBuilder<LoginController>(
                                                    builder: (_) {
                                              return controller
                                                      .isLoadingDashboard
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  : ElevatedButton(
                                                      onPressed: controller
                                                                  .numberController
                                                                  .text
                                                                  .length ==
                                                              11
                                                          ? () {
                                                              if (formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                // controller
                                                                //     .goToDashboard();

                                                                //if need verify

                                                                controller
                                                                    .changeVerification(
                                                                        true);
                                                                controller
                                                                    .sendCodeRequest();
                                                              }
                                                            }
                                                          : null,
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xffE57C23),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                      ),
                                                      child: const Text(
                                                        'ادامه',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    );
                                            })),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                : Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (controller.verification)
                                          Row(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    controller
                                                        .changeVerification(
                                                            false);
                                                  },
                                                  child: const Icon(
                                                    Icons.arrow_back_outlined,
                                                    color: Colors.grey,
                                                  )),
                                            ],
                                          ),
                                        const Text(
                                          'کد تایید را وارد نمایید',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'کد تایید برای شماره ${controller.numberController.text} ارسال گردید',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 20,
                                                offset: const Offset(0, 5),
                                              ),
                                            ],
                                          ),
                                          child: TextFormField(
                                            controller:
                                                controller.verifyController,
                                            focusNode:
                                                controller.verifyFocusNode,
                                                
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  4),
                                            ],
                                            decoration: InputDecoration(
                                              labelText: 'کد تایید',
                                              // hintText: 'hintText',
                                              // fillColor: Colors.white,
                                              filled: true,
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20, 10),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .grey.shade400)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red,
                                                      width: 2.0)),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors.red,
                                                              width: 2.0)),
                                            ),
                                            validator: (val) {
                                              if ((val!.isEmpty) ||
                                                  val.length != 4) {
                                                return 'کد تایید را صحیح وارد نمایید';
                                              }
                                              return null;
                                            },
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(child:
                                                GetBuilder<LoginController>(
                                                    builder: (_) {
                                              return ElevatedButton(
                                                onPressed: controller
                                                        .resendVerification
                                                    ? () {
                                                        controller
                                                            .changeResendVerification(
                                                                false);
                                                        controller
                                                            .timerController!
                                                            .restart();
                                                      }
                                                    : null,
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xffE57C23),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                child: const Text(
                                                  'ارسال مجدد کد تایید',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              );
                                            })),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                          })),
                    ),
                  ),
                  GetBuilder<LoginController>(builder: (_) {
                    return controller.verification
                        ? Container(
                            width: 85,
                            padding: const EdgeInsets.only(top: 16),
                            child: SimpleTimer(
                              duration: const Duration(seconds: 60),
                              controller: controller.timerController,
                              timerStyle: controller.timerStyle,
                              onStart: controller.handleTimerOnStart,
                              onEnd: controller.handleTimerOnEnd,
                              valueListener:
                                  controller.timerValueChangeListener,
                              backgroundColor: const Color(0xffE57C23),
                              progressIndicatorColor: Colors.grey,
                              progressIndicatorDirection:
                                  controller.progressIndicatorDirection,
                              progressTextCountDirection:
                                  controller.progressTextCountDirection,
                              progressTextStyle: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                              strokeWidth: 10,
                            ),
                          )
                        : const SizedBox();
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
