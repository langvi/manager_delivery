part of 'detail_customer_bloc.dart';

@immutable
abstract class DetailCustomerState {}

class DetailCustomerInitial extends DetailCustomerState {}

class Loading extends DetailCustomerState {}

class Error extends DetailCustomerState {
  final String message;

  Error({this.message = 'Lỗi'});
}

class GetProductSuccess extends DetailCustomerState {
  final List<Product> products;
  final int totalCreate;
  final int totalGetting;
  final int totalShipping;
  final int totalShiped;

  GetProductSuccess(
      {this.products,
      this.totalCreate,
      this.totalGetting,
      this.totalShipping,
      this.totalShiped});
}

class FindSuccess extends DetailCustomerState {
  final Product product;

  FindSuccess(this.product);
}
