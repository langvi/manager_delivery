part of 'employee_bloc.dart';

@immutable
abstract class EmployeeEvent {}

class GetEmployees extends EmployeeEvent {
  final bool isLoadMore;
  final bool isRefresh;

  GetEmployees({this.isLoadMore = false, this.isRefresh = false});
}

class FindShipper extends EmployeeEvent {
  final String keySearch;

  FindShipper(this.keySearch);
}
