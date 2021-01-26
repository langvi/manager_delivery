import 'dart:async';

import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/features/login/model/login_repository.dart';
import 'package:manage_delivery/main.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  final _loginRepository = LoginRepository();
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
    var response = await _loginRepository.login(event.name, event.password);
    if (response.isSuccess) {
      prefs.setString(AppConst.keyToken, response.data);
      yield LoginSuccess();
    } else {
      yield LoginError(response.message);
    }
  }
}
