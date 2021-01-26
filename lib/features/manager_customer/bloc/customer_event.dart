part of 'customer_bloc.dart';

@immutable
abstract class CustomerEvent {}

class GetAllCustomer extends CustomerEvent {
  final bool isLoadMore;
  final bool isRefresh;

  GetAllCustomer({this.isLoadMore = false, this.isRefresh = false});
}

class FindCustomer extends CustomerEvent {
  final String keySearch;

  FindCustomer(this.keySearch);
}
