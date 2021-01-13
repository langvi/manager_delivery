part of 'employee_bloc.dart';

@immutable
abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class Loading extends EmployeeState {}

class GetEmployeeSuccess extends EmployeeState {
  final List<Employee> employees;
  final int totalShipper;

  GetEmployeeSuccess(this.employees, this.totalShipper);
}

class Error extends EmployeeState {
  final String message;

  Error(this.message);
}
