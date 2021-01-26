import 'dart:async';

import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:manage_delivery/features/manager_employee/model/employee_repository.dart';
import 'package:manage_delivery/features/manager_employee/model/employee_response.dart';
import 'package:meta/meta.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends BaseBloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial());
  final _employeeRepo = EmployeeRepository();
  int pageIndex = 0;
  @override
  void onError(Object error, StackTrace stacktrace) {
    if (pageIndex > 0) {
      pageIndex--;
    }
    super.onError(error, stacktrace);
  }

  @override
  Stream<EmployeeState> mapEventToState(
    EmployeeEvent event,
  ) async* {
    if (event is GetEmployees) {
      yield* _getEmployee(event);
    } else if (event is FindShipper) {
      yield* _findShipper(event);
    }
  }

  Stream<EmployeeState> _getEmployee(GetEmployees event) async* {
    if (event.isLoadMore) {
      pageIndex++;
    } else if (event.isRefresh) {
      pageIndex = 0;
    } else {
      yield Loading();
    }
    var res = await _employeeRepo.getEmployees(pageIndex: pageIndex);
    if (res.isSuccess) {
      if (res.data.employees.isEmpty) {
        if (pageIndex > 0) {
          pageIndex--;
        }
      }
      yield GetEmployeeSuccess(res.data.employees, res.data.totalShipper,
          isLoadMore: event.isLoadMore);
    } else {
      yield Error('Lỗi');
    }
  }

  Stream<EmployeeState> _findShipper(FindShipper event) async* {
    yield Loading();
    var res = await _employeeRepo.findShipper(event.keySearch);
    if (res.isSuccess) {
      yield GetEmployeeSuccess(res.data.employees, res.data.totalShipper);
    } else {
      yield Error('Lỗi');
    }
  }
}
