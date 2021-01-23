import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/request/base_request.dart';
import 'package:manage_delivery/features/statistic/model/chart_response.dart';

class ChartRepository {
  final _baseRequest = BaseRequest();
  Future<ChartResponse> getData(DateTime fromDate, DateTime toDate) async {
    var response = await _baseRequest.sendRequest(
        AppConst.getCountProductByTimeUrl, RequestMethod.GET,
        queryParams: {
          "fromDate": fromDate == null ? null : fromDate.millisecondsSinceEpoch,
          "toDate": toDate == null ? null : toDate.millisecondsSinceEpoch
        });
    return ChartResponse.fromJson(response);
  }
}
