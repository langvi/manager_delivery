import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/request/base_request.dart';
import 'package:manage_delivery/features/manager_customer/model/customer_response.dart';
import 'package:manage_delivery/features/manager_customer/model/product_res.dart';

class CustomerRepository {
  final _baseRequest = BaseRequest();
  Future<CustomerResponse> getCustomers() async {
    var res = await _baseRequest.sendRequest(
        AppConst.getCustomerUrl, RequestMethod.GET);
    return CustomerResponse.fromJson(res);
  }

  Future<ProductCusResponse> getProductbyCustomer(String id) async {
    var res = await _baseRequest.sendRequest(
        AppConst.getProductOfCustomerUrl, RequestMethod.GET,
        queryParams: {'_id': id});
    return ProductCusResponse.fromJson(res);
  }
}
