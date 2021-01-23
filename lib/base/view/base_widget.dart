import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BaseWidget {
  static Widget buildLogout(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.red,
      child: Text(
        'Đăng xuất',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  static Widget buildFooter() {
    return CustomFooter(builder: (context, mode) {
      if (mode == LoadStatus.loading) {
        return CupertinoActivityIndicator();
      } else {
        return Visibility(visible: false, child: CupertinoActivityIndicator());
      }
    });
  }
}
