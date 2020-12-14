import 'package:dio/dio.dart';
import 'package:manage_delivery/base/consts/const.dart';
enum RequestMethod { POST, GET, PUT }

class BaseRequest {
  static Dio dio = Dio();
  static final _singleton = BaseRequest._internal();

  factory BaseRequest() {
    dio.options.connectTimeout = 15000;
    dio.options.baseUrl = AppConst.baseUrl;
    return _singleton;
  }
  BaseRequest._internal();

  Future<dynamic> sendRequest(String path, RequestMethod requestMethod,
      {dynamic jsonMap,
      bool sendHeader = true,
      bool isTokenPre = false,
      dynamic queryParams}) async {
    Response response;

    if (requestMethod == RequestMethod.POST) {
      response = await dio.post(path,
          data: jsonMap,
          options:
              Options(headers: sendHeader ? _getHearder(isTokenPre) : null),
          queryParameters: queryParams);
    } else if (requestMethod == RequestMethod.GET) {
      response = await dio.get(
        path,
        options: Options(headers: sendHeader ? _getHearder(isTokenPre) : null),
        queryParameters: queryParams,
      );
    } else if (requestMethod == RequestMethod.PUT) {
      response = await dio.put(path,
          data: jsonMap,
          options:
              Options(headers: sendHeader ? _getHearder(isTokenPre) : null));
    }
    return response.data;
  }

  Map<String, dynamic> _getHearder(bool isTokenPre) {
    String token = '';

    // token = isTokenPre
    //     ? prefs.getString(AppConst.keyTokenPre)
    //     : prefs.getString(AppConst.keyTokenAfter);

    return {"Authorization": "Bearer $token"};
  }
}
