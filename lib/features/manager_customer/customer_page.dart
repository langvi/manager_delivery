import 'package:flutter/material.dart';
import 'package:manage_delivery/base/view/base_widget.dart';

class CustomerPage extends StatefulWidget {
  CustomerPage({Key key}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Quản lí khách hàng'),
            BaseWidget.buildLogout(context)
          ],
        ),
      ),
      body: Center(
        child: Text('customer'),
      ),
    );
  }
}
