part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class GetAllProduct extends ProductEvent {
  final bool isLoadMore;
  final bool isRefresh;

  GetAllProduct({this.isLoadMore = false, this.isRefresh = false});
}

class GetInforProduct extends ProductEvent {}

class GetInforCustomer extends ProductEvent {
  final Product product;

  GetInforCustomer(this.product);
}
