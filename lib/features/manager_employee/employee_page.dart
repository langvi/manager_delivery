import 'package:flutter/material.dart';
import 'package:manage_delivery/base/view/base_widget.dart';

class EmployeePage extends StatefulWidget {
  EmployeePage({Key key}) : super(key: key);

  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
         title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Quản lí nhân viên'),
            BaseWidget.buildLogout(context)
          ],
        ),
      ),
      body: Center(
        child: Text('employee'),
      ),
    );
  }
}
