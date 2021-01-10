part of 'enter_bloc.dart';

@immutable
abstract class EnterState {}

class EnterInitial extends EnterState {}

class Error extends EnterState {
  final String message;

  Error(this.message);
}

class EnterSuccess extends EnterState {
  final Product product;

  EnterSuccess(this.product);
}
