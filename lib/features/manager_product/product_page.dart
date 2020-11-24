import 'package:flutter/material.dart';
import 'package:manage_delivery/base/view/base_widget.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //  title: Text('Quản lí hàng hóa'),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Quản lí hàng hóa'), BaseWidget.buildLogout(context)],
        ),
      ),
      body: Center(
        child: Text('product'),
      ),
    );
  }
}
