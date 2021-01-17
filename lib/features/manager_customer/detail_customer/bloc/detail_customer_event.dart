part of 'detail_customer_bloc.dart';

@immutable
abstract class DetailCustomerEvent {}

class GetProductByCustomer extends DetailCustomerEvent {
  final String customerId;

  GetProductByCustomer(this.customerId);
}
