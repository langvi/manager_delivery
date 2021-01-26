part of 'detail_employee_bloc.dart';

@immutable
abstract class DetailEmployeeEvent {}

class GetProductOfEmployee extends DetailEmployeeEvent {
  final String employeeId;
  final DateTime fromDate;
  final DateTime toDate;
  GetProductOfEmployee(this.employeeId, this.fromDate, this.toDate);
}

class UpdateShipper extends DetailEmployeeEvent {
  final Employee employee;

  UpdateShipper(this.employee);
}
