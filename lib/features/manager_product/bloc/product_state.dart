part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class Loading extends ProductState {}

class GetAllProductSuccess extends ProductState {
  final List<Product> products;

  GetAllProductSuccess(this.products);
}

class Error extends ProductState {}
