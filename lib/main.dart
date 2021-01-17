import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:manage_delivery/features/manager_customer/detail_customer/detail_customer_page.dart';
import 'package:manage_delivery/features/manager_employee/detail_employee/detail_employee_page.dart';
import 'package:manage_delivery/features/manager_product/address/address_page.dart';
import 'package:manage_delivery/features/manager_product/create_product/create_product_page.dart';
import 'package:manage_delivery/features/manager_product/detail_product/detail_product_page.dart';
import 'package:manage_delivery/features/manager_product/enter_product/enter_product_page.dart';
import 'package:manage_delivery/features/manager_product/update_address/update_address_page.dart';
import 'package:manage_delivery/features/manager_product/update_product/update_page.dart';
import 'package:manage_delivery/utils/key_board.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/consts/const.dart';
import 'features/home/home_page.dart';
import 'features/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await prefsInstance;
  runApp(MyApp());
}

final prefsInstance = SharedPreferences.getInstance();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

SharedPreferences prefs;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
      },
      child: MaterialApp(
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [
          const Locale('vi'),
        ],
        title: 'Manager Delivery',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: (setting) => _onGenerateRoute(setting),
        home: LoginPage(),
      ),
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
      case AppConst.routeDetailProduct:
        return DetailProductPage();
      case AppConst.routeDetailCustomer:
        return DetailCustomerPage();
      case AppConst.routeDetailShipper:
        return DetailEmployeePage();
      case AppConst.routeEnterProduct:
        return EnterProductPage();
      case AppConst.routeUpdateProduct:
        return UpdatePage();
      case AppConst.routeUpdateAddress:
        return UpdateAddressPage();
    }
    return null;
  }
}
