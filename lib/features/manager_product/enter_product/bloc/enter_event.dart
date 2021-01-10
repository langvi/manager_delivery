part of 'enter_bloc.dart';

@immutable
abstract class EnterEvent {}

class EnterProduct extends EnterEvent {
  final String id;

  EnterProduct(this.id);
}
