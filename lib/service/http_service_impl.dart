import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

import 'package:things_dashboard/service/http_service.dart';


class HttpServiceImpl implements HttpService {
  late Dio _dio;

  @override
  void init() {
    _dio = Dio();

    initializeInterceptors();
  }

  @override
  Future getRequest(String url) async {
    _dio.options.headers.addAll({
      // "Authorization": "Bearer " + token.toString()
      // "Authorization":
      //     // "Bearer meYFX1nn6ewWBVIK2ExR.eyJzdWIiOiJtaXJpaGFtaWRyZXphQHNhaXBhY29ycC5jb20iLCJ1c2VySWQiOiI1MmQ2NDA4MC1mODkyLTExZWQtYWI3MC04OWQ0YzNkMjA4MDYiLCJzY29wZXMiOlsiVEVOQU5UX0FETUlOIl0sInNlc3Npb25JZCI6IjA2YTBjYjljLWM2NzYtNDE4Yy05Y2FhLTE0Nzg1OGQ4ZGM0ZCIsImlzcyI6InRoaW5nc2JvYXJkLmlvIiwiaWF0IjoxNzAwMzA0MDM1LCJleHAiOjE3MDAzMTMwMzUsImZpcnN0TmFtZSI6IkhhbWlkcmV6YSIsImxhc3ROYW1lIjoiTWlyaSIsImVuYWJsZWQiOnRydWUsImlzUHVibGljIjpmYWxzZSwidGVuYW50SWQiOiI0Yjg4NjE1MC1lZTY1LTExZWQtOTU5OC05MWExMmU3OGFhMzUiLCJjdXN0b21lcklkIjoiMTM4MTQwMDAtMWRkMi0xMWIyLTgwODAtODA4MDgwODA4MDgwIn0.Dg5XBNZyuwJDDYxzkZGSYZ7BFEU26IeAjjrZ41D09A9Z_F0H4YnBRkuE1HgStcyfI9gkaRwphmnxW2aqC_KOjA"
      //     "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJtaXJpaGFtaWRyZXphQHNhaXBhY29ycC5jb20iLCJ1c2VySWQiOiI1MmQ2NDA4MC1mODkyLTExZWQtYWI3MC04OWQ0YzNkMjA4MDYiLCJzY29wZXMiOlsiVEVOQU5UX0FETUlOIl0sInNlc3Npb25JZCI6IjA2YTBjYjljLWM2NzYtNDE4Yy05Y2FhLTE0Nzg1OGQ4ZGM0ZCIsImlzcyI6InRoaW5nc2JvYXJkLmlvIiwiaWF0IjoxNzAwMzA0MDM1LCJleHAiOjE3MDAzMTMwMzUsImZpcnN0TmFtZSI6IkhhbWlkcmV6YSIsImxhc3ROYW1lIjoiTWlyaSIsImVuYWJsZWQiOnRydWUsImlzUHVibGljIjpmYWxzZSwidGVuYW50SWQiOiI0Yjg4NjE1MC1lZTY1LTExZWQtOTU5OC05MWExMmU3OGFhMzUiLCJjdXN0b21lcklkIjoiMTM4MTQwMDAtMWRkMi0xMWIyLTgwODAtODA4MDgwODA4MDgwIn0.Dg5XBNZyuwJDDYxzkZGSYZ7BFEU26IeAjjrZ41D09A9Z_F0H4YnBRkuE1HgStcyfI9gkaRwphmnxW2aqC_KOjA"
    });
    // try {
    Response response = await _dio.get(url);
    // } on DioError {
    //   rethrow;
    // }

    return response.data;
  }

  @override
  Future postRequest(
    String url,
    dynamic data,
  ) async {
    // try {
    // if (token != null && token != "") {
    _dio.options.headers.addAll({
      //  "Authorization":
      // "JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzI2NTU1MDQwLCJpYXQiOjE2OTUwMTkwNDAsImp0aSI6ImVhYzE4ZDVhMzJhYzQ2NWRhNTdjMTdlMzZjNjYwNGEwIiwidXNlcl9pZCI6MX0.eChHVPRXb8lckUivte8XNG-ZAEfeImsN1ic8G-Ea_bs"
    });
    // }
    var formdata = data;
    if (data is Map) {
      formdata = (data != null && data != {}) ? json.encode(data) : null;
    }
    Response response = await _dio.post(url, data: formdata);
    // } on DioError {
    //   rethrow;
    // }

    return response.data;
  }

  initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log("onRequest : ${options.method} , ${options.data.toString()} ,${options.path}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // log("onResponse : ${response.statusCode.toString()}  , ${response.statusMessage.toString()} ,  ${response.data.toString()} ");
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          // log("interceptors onError ${e.toString()}");
          Fluttertoast.showToast(
              msg: e.message ?? "somthing went wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          handler.next(e);
        },
      ),
    );
  }
}
