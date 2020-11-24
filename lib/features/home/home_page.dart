import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manage_delivery/features/manager_customer/customer_page.dart';
import 'package:manage_delivery/features/manager_employee/employee_page.dart';
import 'package:manage_delivery/features/manager_product/product_page.dart';
import 'package:manage_delivery/features/statistic/statistic_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _pageController = PageController(initialPage: 0);
  DateTime _currentBackPressTime;
  bool isShowBottomNav = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: PageView(
              controller: _pageController,
              onPageChanged: onTabChange,
              children: [
                ProductPage(),
                CustomerPage(),
                EmployeePage(),
                StatisticPage(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Visibility(
          visible: isShowBottomNav,
          child: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            iconSize: 24,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: onClickTab,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(MaterialIcons.local_grocery_store),
                label: 'Hàng hóa',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Khách hàng',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Shipper',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesome.bar_chart),
                label: 'Thống kê',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTabChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void onClickTab(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime) > Duration(seconds: 2)) {
      _currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Chạm lần nữa để thoát');
      return Future.value(false);
    } else {
      exit(0);
    }
  }
}
