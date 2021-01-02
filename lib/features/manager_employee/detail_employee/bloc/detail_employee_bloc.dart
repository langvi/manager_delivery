import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:meta/meta.dart';

part 'detail_employee_event.dart';
part 'detail_employee_state.dart';

class DetailEmployeeBloc extends BaseBloc<DetailEmployeeEvent, DetailEmployeeState> {
  DetailEmployeeBloc() : super(DetailEmployeeInitial());

  @override
  Stream<DetailEmployeeState> mapEventToState(
    DetailEmployeeEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
