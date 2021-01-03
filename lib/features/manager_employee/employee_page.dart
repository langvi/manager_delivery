import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/view/base_staful_widget.dart';
import 'package:manage_delivery/base/view/base_widget.dart';
import 'package:manage_delivery/features/manager_employee/bloc/employee_bloc.dart';

class EmployeePage extends StatefulWidget {
  EmployeePage({Key key}) : super(key: key);

  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState
    extends BaseStatefulWidgetState<EmployeePage, EmployeeBloc> {
  @override
  void initBloc() {
    bloc = EmployeeBloc();
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return BlocProvider<EmployeeBloc>(
      create: (context) => bloc,
      child: BlocConsumer<EmployeeBloc, EmployeeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return baseShowLoading(
              child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: AppColors.mainColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text('Shipper'),
              actions: [
                IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: () {})
              ],
            ),
            body: _buildBody(),
          ));
        },
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTitle(),
          SizedBox(
            height: 5,
          ),
          _buildListShipper()
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.all(10),
      color: AppColors.mainColor,
      height: 100,
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.grey[400], Colors.white]),
                  shape: BoxShape.circle),
              child: Image.asset('assets/images/icon_ship.png')),
          SizedBox(
            width: 10,
          ),
          RichText(
            text: TextSpan(
                text: '50',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: '\nShipper',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  )
                ]),
          ),
        ],
      ),
    );
  }

  Widget _buildListShipper() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
          itemCount: 10,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _buildItem(index);
          }),
    );
  }

  Widget _buildItem(int index) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppConst.routeDetailShipper);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.symmetric(vertical: 5),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: CircleAvatar(
                  backgroundImage: Image.asset(
                    'assets/images/no_avatar.png',
                    fit: BoxFit.fill,
                  ).image,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Ha Van SH',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: RichText(
                        text: TextSpan(
                            text: 'Số điện thoại: ',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: '0123546987',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: RichText(
                        text: TextSpan(
                            text: 'Khu vực giao: ',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Đống Đa - Hà Nội',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.phone,
                    color: Colors.blue,
                  ),
                  onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
  
}
