import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/request/base_request.dart';
import 'package:manage_delivery/features/manager_product/model/infor_response.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';

class ProductRepository {
  final _baseRequest = BaseRequest();
  Future<ProductResponse> getAllProduct({int pageIndex = 0}) async {
    var response = await _baseRequest.sendRequest(
        AppConst.getAllProductUrl, RequestMethod.GET,
        queryParams: {'pageIndex': pageIndex});
    return ProductResponse.fromJson(response);
  }

  Future<InforResponse> getInforProduct() async {
    var response = await _baseRequest.sendRequest(
      AppConst.getInforProductUrl,
      RequestMethod.GET,
    );
    return InforResponse.fromJson(response);
  }

  Future<CustomerProductResponse> getInforCustomerOfProduct(String id) async {
    var response = await _baseRequest.sendRequest(
        AppConst.getProductCustomerUrl, RequestMethod.GET,
        queryParams: {'id': id});
    return CustomerProductResponse.fromJson(response);
  }
}
