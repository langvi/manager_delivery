import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/request/base_request.dart';
import 'package:manage_delivery/base/request/base_response.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';

class CreateRepository {
  final _baseRequest = BaseRequest();
  Future<BaseResponse> createProduct(Product product) async {
    var res = await _baseRequest.sendRequest(
        AppConst.createProductUrl, RequestMethod.POST,
        jsonMap: product.toJson());
    return BaseResponse.fromJson(res);
  }

  Future<BaseResponse> updateProduct(Product product) async {
    var res = await _baseRequest.sendRequest(
        AppConst.updateProductUrl + '/${product.id}', RequestMethod.PUT,
        jsonMap: product.toJson());
    return BaseResponse.fromJson(res);
  }
}
