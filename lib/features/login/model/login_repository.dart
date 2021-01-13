import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/request/base_request.dart';
import 'package:manage_delivery/base/request/base_response.dart';

class LoginRepository {
  final _baseRequest = BaseRequest();
  Future<BaseResponse> login(String userName, String password) async {
    var response = await _baseRequest.sendRequest(
        AppConst.loginUrl, RequestMethod.POST,
        sendHeader: false,
        jsonMap: {"accountName": userName, "password": password});
    return BaseResponse.fromJson(response);
  }
}
