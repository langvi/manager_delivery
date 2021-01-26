import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/request/base_request.dart';
import 'package:manage_delivery/features/manager_customer/model/customer_response.dart';
import 'package:manage_delivery/features/manager_customer/model/product_res.dart';

class CustomerRepository {
  final _baseRequest = BaseRequest();
  Future<CustomerResponse> getCustomers(int pageIndex) async {
    var res = await _baseRequest.sendRequest(
        AppConst.getCustomerUrl, RequestMethod.GET,
        queryParams: {'pageIndex': pageIndex});
    return CustomerResponse.fromJson(res);
  }

  Future<CustomerResponse> findCustomer(String name) async {
    var res = await _baseRequest.sendRequest(
        AppConst.findCustomerUrl, RequestMethod.GET,
        queryParams: {'keySearch': name});
    return CustomerResponse.fromJson(res);
  }

  Future<ProductCusResponse> getProductbyCustomer(String id) async {
    var res = await _baseRequest.sendRequest(
        AppConst.getProductOfCustomerUrl, RequestMethod.GET,
        queryParams: {'_id': id});
    return ProductCusResponse.fromJson(res);
  }

  Future<CustomerResponse> getCustomerByArea(int areaId) async {
    var res = await _baseRequest.sendRequest(
        AppConst.getCustomerByAreaUrl, RequestMethod.GET,
        queryParams: {'area': areaId});
    return CustomerResponse.fromJson(res);
  }

  Future<FindResponse> findProductByCustomer(
      String customerId, int productId) async {
    var res = await _baseRequest.sendRequest(
        AppConst.findOneProductUrl, RequestMethod.GET,
        queryParams: {'id': productId, 'customerId': customerId});
    return FindResponse.fromJson(res);
  }
}
