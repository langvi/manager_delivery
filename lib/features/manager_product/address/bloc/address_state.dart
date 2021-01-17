part of 'address_bloc.dart';

@immutable
abstract class AddressState {}

class AddressInitial extends AddressState {}

class Loading extends AddressState {}

class CreateProductSuccess extends AddressState {}

class Error extends AddressState {}
