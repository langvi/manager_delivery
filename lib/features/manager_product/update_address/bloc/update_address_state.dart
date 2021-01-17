part of 'update_address_bloc.dart';

@immutable
abstract class UpdateAddressState {}

class UpdateAddressInitial extends UpdateAddressState {}

class Loading extends UpdateAddressState {}

class Success extends UpdateAddressState {}

class Error extends UpdateAddressState {}
