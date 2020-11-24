import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_delivery/base/consts/string_value.dart';

abstract class BaseBloc<E, S> extends Bloc<E, S> {
  Function(Object error, StackTrace stacktrace) onErrorCallBack;
  E currentEvent;

  BaseBloc(S initialState) : super(initialState);

  void setOnErrorListener(
      Function(Object error, StackTrace stacktrace) onErrorCallBack) {
    this.onErrorCallBack = onErrorCallBack;
  }

  @override
  void onEvent(E event) {
    currentEvent = event;
    super.onEvent(event);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    String errorContent = AppStr.errorConnectFailedStr;
    if (error is DioError) {
      if (error.response?.data != null && error.response.data is Map) {
        errorContent = error.response.data['message'];
      } else if (error.type != null) {
        switch (error.type) {
          case DioErrorType.CONNECT_TIMEOUT:
          case DioErrorType.SEND_TIMEOUT:
          case DioErrorType.RECEIVE_TIMEOUT:
            errorContent = AppStr.errorConnectTimeOut;
            // BaseRequest.dio?.close();
            break;
          case DioErrorType.RESPONSE:
            switch (error.response.statusCode) {
              case 400:
                errorContent = AppStr.error400;
                break;
              case 401:
                errorContent = AppStr.error401;
                break;
              case 404:
                errorContent = AppStr.error404;
                break;
              case 500:
                errorContent = AppStr.errorInternalServer;
                break;

              default:
                errorContent = AppStr.errorInternalServer;
            }
            break;
          default:
            errorContent = AppStr.errorConnectFailedStr;
        }
      }
    }

    print('errorContent -> $errorContent');
    if (onErrorCallBack != null) onErrorCallBack(errorContent, stacktrace);
    super.onError(error, stacktrace);
  }
}
