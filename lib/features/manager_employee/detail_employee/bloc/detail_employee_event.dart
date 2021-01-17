part of 'detail_employee_bloc.dart';

@immutable
abstract class DetailEmployeeEvent {}

class GetProductOfEmployee extends DetailEmployeeEvent {
  final String employeeId;

  GetProductOfEmployee(this.employeeId);
}
