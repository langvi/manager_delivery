import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:manage_delivery/features/manager_employee/model/employee_repository.dart';
import 'package:manage_delivery/features/manager_employee/model/employee_response.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';
import 'package:meta/meta.dart';

part 'detail_employee_event.dart';
part 'detail_employee_state.dart';

class DetailEmployeeBloc
    extends BaseBloc<DetailEmployeeEvent, DetailEmployeeState> {
  DetailEmployeeBloc() : super(DetailEmployeeInitial());
  final _employeeRepo = EmployeeRepository();
  @override
  Stream<DetailEmployeeState> mapEventToState(
    DetailEmployeeEvent event,
  ) async* {
    if (event is UpdateShipper) {
      yield* _updateShipper(event);
    } else if (event is GetProductOfEmployee) {
      yield* _getProductByTime(event);
    }
  }

  Stream<DetailEmployeeState> _updateShipper(UpdateShipper event) async* {
    yield Loading();
    var res = await _employeeRepo.updateShipper(event.employee);
    if (res.isSuccess) {
      yield UpdateSuccess();
    } else {
      yield Error();
    }
  }

  Stream<DetailEmployeeState> _getProductByTime(
      GetProductOfEmployee event) async* {
    yield Loading();
    var res = await _employeeRepo.getProductByTime(
        id: event.employeeId, fromDate: event.fromDate, toDate: event.toDate);
    if (res.isSuccess) {
      yield GetProductSuccess(res.data);
    } else {
      yield Error();
    }
  }
}
