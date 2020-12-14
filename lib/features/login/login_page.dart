import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/view/base_staful_widget.dart';
import 'package:manage_delivery/features/login/bloc/login_bloc.dart';
import 'package:manage_delivery/utils/input_text.dart';
import 'package:manage_delivery/utils/validator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseStatefulWidgetState<LoginPage, LoginBloc> {
  TextEditingController userNameController = TextEditingController(text: 'test1');
  TextEditingController passwordController = TextEditingController(text: '123456');
  final _userNameFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  void initBloc() {
    bloc = LoginBloc();
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => bloc,
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            print('login sucess');
            Navigator.pushNamed(context, AppConst.routeHome);
          } else if (state is LoginError) {
            print('login error');
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: _buildBody(),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            child: Center(child: Image.asset('assets/images/logo_app.png')),
            // child: Image.asset('assets/images/logo_login.png'),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: BuildTextInput(
                    hintText: 'Tên đăng nhập',
                    iconNextTextInputAction: TextInputAction.next,
                    controller: userNameController,
                    currentNode: _userNameFocus,
                    nextNode: _passwordFocus,
                    validator: (value) {
                      if (isStringEmpty(value)) {
                        return 'Tên đăng nhập không được để trống';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: BuildTextInput(
                    obscureText: true,
                    hintText: 'Mật khẩu',
                    controller: passwordController,
                    currentNode: _passwordFocus,
                    iconNextTextInputAction: TextInputAction.done,
                    validator: (value) {
                      if (isInvalidTextInput(value, CheckValidation.PASSWORD)) {
                        return 'Mật khẩu tối thiểu 6 kí tự';
                      }
                      return null;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      onTap: () {
                        // Navigator.pushNamed(
                        //     context, AppConst.routeForgotPassword);
                      },
                      child: Text(
                        'Quên mật khẩu',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 10),
                  child: Container(
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            // bloc.add(Login(userNameController.text, ''));
                            Navigator.pushNamed(context, AppConst.routeHome);
                          }
                        },
                        child: Text('Đăng nhập'.toUpperCase()),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
