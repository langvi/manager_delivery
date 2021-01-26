part of 'detail_employee_bloc.dart';

@immutable
abstract class DetailEmployeeState {}

class DetailEmployeeInitial extends DetailEmployeeState {}

class Loading extends DetailEmployeeState {}

class GetProductSuccess extends DetailEmployeeState {
  final List<Product> products;

  GetProductSuccess(this.products);
}

class UpdateSuccess extends DetailEmployeeState {}

class Error extends DetailEmployeeState {}
