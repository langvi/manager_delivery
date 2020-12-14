import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is Login) {
      yield* _login(event);
    }
  }

  Stream<LoginState> _login(Login event) async* {
    yield Loading();
    Dio dio = Dio();
    var response = await dio.post('http://192.168.0.107:8080/api/demo',
        data: {"name": event.name, "age": "22"});
    if (response != null) {
      yield LoginSuccess();
    } else {
      yield LoginError();
    }
  }
}
