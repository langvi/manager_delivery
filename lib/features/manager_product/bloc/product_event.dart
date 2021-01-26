part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class GetAllProduct extends ProductEvent {
  final bool isLoadMore;
  final bool isRefresh;
  final int type;

  GetAllProduct(
      {this.isLoadMore = false, this.isRefresh = false, this.type = 0});
}

class GetInforProduct extends ProductEvent {
  final bool isRefresh;

  GetInforProduct({this.isRefresh = false});
}

class GetInforCustomer extends ProductEvent {
  final Product product;

  GetInforCustomer(this.product);
}

class FindProduct extends ProductEvent {
  final String keySearch;

  FindProduct(this.keySearch);
}
