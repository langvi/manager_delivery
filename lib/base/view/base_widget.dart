import 'package:flutter/material.dart';

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
}
