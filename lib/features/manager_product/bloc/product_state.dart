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

class GetMoreProductSuccess extends ProductState {
  final List<Product> products;

  GetMoreProductSuccess(this.products);
}

class GetInforSuccess extends ProductState {
  final InforProduct inforProduct;

  GetInforSuccess(this.inforProduct);
}

class GetInforCustomerSuccess extends ProductState {
  final CustomerProduct customerProduct;

  GetInforCustomerSuccess(this.customerProduct);
}
