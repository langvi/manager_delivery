part of 'update_address_bloc.dart';

@immutable
abstract class UpdateAddressEvent {}

class UpdateProduct extends UpdateAddressEvent {
  final Product product;

  UpdateProduct(this.product);
}
