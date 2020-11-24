import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial());

  @override
  Stream<EmployeeState> mapEventToState(
    EmployeeEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
