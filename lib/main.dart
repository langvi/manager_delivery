import 'package:flutter/material.dart';
import 'package:manage_delivery/features/manager_product/add_address/add_address_page.dart';
import 'package:manage_delivery/features/manager_product/create_product/create_product_page.dart';

import 'base/consts/const.dart';
import 'features/home/home_page.dart';
import 'features/login/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manager Delivery',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (setting) => _onGenerateRoute(setting),
      home: LoginPage(),
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => _getWidgetByRoute(settings.name),
      transitionsBuilder: (_, Animation<double> animation,
          Animation<double> second, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: FadeTransition(
            opacity: Tween<double>(begin: 1.0, end: 0.0).animate(second),
            child: child,
          ),
        );
      },
    );
  }

  Widget _getWidgetByRoute(String routeName) {
    switch (routeName) {
      case AppConst.routeHome:
        return HomePage();
      case AppConst.routeCreateProduct:
        return CreateProductPage();
      case AppConst.routeCreateAddress:
        return AddressPage();
    }
    return null;
  }
}
