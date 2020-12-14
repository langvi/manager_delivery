part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class Login extends LoginEvent {
  final String name;
  final String password;

  Login(this.name, this.password);
}
