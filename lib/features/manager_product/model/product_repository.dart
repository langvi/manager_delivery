import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/request/base_request.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';

class ProductRepository {
  final _baseRequest = BaseRequest();
  Future<ProductResponse> getAllProduct() async {
    var response = await _baseRequest.sendRequest(
        AppConst.getAllProductUrl, RequestMethod.GET);
    return ProductResponse.fromJson(response);
  }
}
