part of 'address_bloc.dart';

@immutable
abstract class AddressEvent {}

class CreateProduct extends AddressEvent {
  final Product product;

  CreateProduct(this.product);
}
