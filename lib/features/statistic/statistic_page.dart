import 'package:flutter/material.dart';
import 'package:manage_delivery/base/view/base_widget.dart';

class StatisticPage extends StatefulWidget {
  StatisticPage({Key key}) : super(key: key);

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title: Text('Thống kê'),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Thống kê'), BaseWidget.buildLogout(context)],
        ),
      ),
      body: Center(
        child: Text('statistic'),
      ),
    );
  }
}
