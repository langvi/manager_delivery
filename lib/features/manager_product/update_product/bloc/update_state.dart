part of 'update_bloc.dart';

@immutable
abstract class UpdateState {}

class UpdateInitial extends UpdateState {}

class Loading extends UpdateState {}

class UpdateSuccess extends UpdateState {}

class Error extends UpdateState {
  final String message;

  Error(this.message);
}
