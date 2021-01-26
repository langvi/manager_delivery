import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:manage_delivery/utils/dialog.dart';

abstract class BaseStatefulWidgetState<SF extends StatefulWidget,
    B extends BaseBloc> extends State<SF> {
  bool isShowLoading = false;

  bool isKeyBoardShow = false;

  /// `Bloc` tuong ung voi tung man hinh
  B bloc;

  // AppBloc appBloc;

  void initBloc();

  Widget buildWidgets(BuildContext context);

  @override
  void initState() {
    // handleInitState();

    initBloc();
    bloc?.setOnErrorListener(showErrorPopup);

    super.initState();
  }

  // void handleInitState() {
  //   if (appBloc == null) appBloc = BlocProvider.of<AppBloc>(context);

  //   /// Callback khi bloc call `onError()`
  //   appBloc.setOnErrorListener(showErrorPopup);
  // }

  @override
  Widget build(BuildContext context) {
    // isKeyBoardShow = KeyBoard.keyboardIsVisible(context);
    return buildWidgets(context);
  }

  void setShowLoading(bool isLoad) {
    if (mounted) {
      isShowLoading = isLoad;
    }
  }

  void showErrorPopup(Object error, StackTrace stacktrace) {
    setState(() {
      setShowLoading(false);
    });
    ShowDialog(context).showNotification(error.toString());
  }

  Widget baseShowLoading({@required Widget child}) {
    return Stack(
      children: [
        child,
        Visibility(
            visible: isShowLoading,
            child: Container(
                color: Colors.black38,
                child: Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.black38,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white)))))
      ],
    );
  }
}
