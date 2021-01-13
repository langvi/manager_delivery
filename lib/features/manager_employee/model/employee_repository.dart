import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/request/base_request.dart';
import 'package:manage_delivery/features/manager_employee/model/employee_response.dart';

class EmployeeRepository {
  final _baseRequest = BaseRequest();
  Future<EmployeeResponse> getEmployees({int pageIndex = 0}) async {
    var response = await _baseRequest.sendRequest(
        AppConst.getEmployeeUrl, RequestMethod.GET,
        queryParams: {"pageIndex": pageIndex});
    return EmployeeResponse.fromJson(response);
  }
}
