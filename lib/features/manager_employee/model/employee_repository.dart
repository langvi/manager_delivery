import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/request/base_request.dart';
import 'package:manage_delivery/base/request/base_response.dart';
import 'package:manage_delivery/features/manager_employee/model/employee_response.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';

class EmployeeRepository {
  final _baseRequest = BaseRequest();
  Future<EmployeeResponse> getEmployees({int pageIndex = 0}) async {
    var response = await _baseRequest.sendRequest(
        AppConst.getEmployeeUrl, RequestMethod.GET,
        queryParams: {"pageIndex": pageIndex});
    return EmployeeResponse.fromJson(response);
  }

  Future<EmployeeResponse> findShipper(String keySearch) async {
    var response = await _baseRequest.sendRequest(
        AppConst.findEmployeeUrl, RequestMethod.GET,
        queryParams: {"keySearch": keySearch});
    return EmployeeResponse.fromJson(response);
  }

  Future<BaseResponse> updateShipper(Employee shipper) async {
    var response = await _baseRequest.sendRequest(
        AppConst.updateEmployeeUrl + '/${shipper.id}', RequestMethod.PUT,
        jsonMap: shipper.toJson());
    return BaseResponse.fromJson(response);
  }

  Future<ProductResponse> getProductByTime(
      {String id, DateTime fromDate, DateTime toDate}) async {
    var response = await _baseRequest.sendRequest(
        AppConst.getProductByEmployeeUrl, RequestMethod.GET,
        queryParams: {
          'fromDate': fromDate.millisecondsSinceEpoch,
          'toDate': toDate.millisecondsSinceEpoch,
          '_id': id
        });
    return ProductResponse.fromJson(response);
  }
}
