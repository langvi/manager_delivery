import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/request/base_request.dart';
import 'package:manage_delivery/features/manager_product/enter_product/model/enter_response.dart';

class EnterRepository {
  final _baseRequest = BaseRequest();
  Future<EnterResponse> enterProduct(String id) async {
    var response = await _baseRequest.sendRequest(
        AppConst.enterProductUrl, RequestMethod.POST,
        jsonMap: {'productId': id});
    return EnterResponse.fromJson(response);
  }
}
