import 'dart:async';
abstract class HttpService {
  void init();
  Future getRequest(String url);
  Future postRequest(String url, dynamic data);
}
