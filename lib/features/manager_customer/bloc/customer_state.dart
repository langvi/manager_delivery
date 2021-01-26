part of 'customer_bloc.dart';

@immutable
abstract class CustomerState {}

class CustomerInitial extends CustomerState {}

class Loading extends CustomerState {}

class Error extends CustomerState {
  final String message;

  Error(this.message);
}

class GetCustomerSuccess extends CustomerState {
  final List<Customer> customers;
  final int totalCustomer;
  final bool isLoadMore;

  GetCustomerSuccess(this.customers, this.totalCustomer,
      {this.isLoadMore = false});
}

class FindSuccess extends CustomerState {
  final List<Customer> customers;

  FindSuccess(this.customers);
}
