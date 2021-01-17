part of 'detail_employee_bloc.dart';

@immutable
abstract class DetailEmployeeState {}

class DetailEmployeeInitial extends DetailEmployeeState {}
class Loading extends DetailEmployeeState {}
class GetSuccess extends DetailEmployeeState {}
class Error extends DetailEmployeeState {}
