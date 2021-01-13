import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowDialog {
  factory ShowDialog(BuildContext context) {
    _instance._context = context;
    return _instance;
  }

  BuildContext _context;
  int _numberDialog = 0;

  static final _instance = ShowDialog._internal();

  ShowDialog._internal();

  void showNotification(String text, {Function functionCloseDialog}) async {
    if (_numberDialog > 0) {
      Navigator.of(_context).pop();
    }
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15.0,
                    ),
                    child: Text(
                      'Thông báo',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(17.0),
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        _numberDialog = 0;
                        Navigator.of(context).pop();
                        if (functionCloseDialog != null) {
                          functionCloseDialog();
                        }
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Text(
                        'Đóng',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    _numberDialog++;
  }

  void showMenuDialog(
      {@required child, bool dismissible = true, BuildContext context}) {
    showDialog(
      context: context ?? _context,
      barrierDismissible: dismissible,
      builder: (context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(padding: const EdgeInsets.all(8.0), child: child),
          ),
        );
      },
    );
  }

  Future<bool> showDialogConfirm(
      {@required String title,
      @required Function funcAccept,
      Function funcCancel,
      String contentRich,
      bool dismissible = true}) async {
    showDialog(
        barrierDismissible: dismissible,
        context: _context,
        builder: (BuildContext context) => WillPopScope(
              onWillPop: () async => false,
              child: CupertinoAlertDialog(
                title: contentRich != null
                    ? RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: title,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                  text: contentRich,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ]))
                    : Text(title),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      funcAccept();
                    },
                    child: Text('Đồng ý'),
                  ),
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    textStyle: TextStyle(color: Colors.red),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      if (funcCancel != null) {
                        funcCancel();
                      }
                    },
                    child: Text('Hủy bỏ'),
                  )
                ],
              ),
            ));
    return false;
  }
}
