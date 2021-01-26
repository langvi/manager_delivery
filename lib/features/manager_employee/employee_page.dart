import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/view/base_staful_widget.dart';
import 'package:manage_delivery/base/view/base_widget.dart';
import 'package:manage_delivery/features/manager_employee/bloc/employee_bloc.dart';
import 'package:manage_delivery/features/manager_employee/model/employee_response.dart';
import 'package:manage_delivery/utils/dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeePage extends StatefulWidget {
  EmployeePage({Key key}) : super(key: key);

  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState
    extends BaseStatefulWidgetState<EmployeePage, EmployeeBloc> {
  List<Employee> employees = [];
  int totalShipper = 0;
  final _refreshController = RefreshController();
  @override
  void initBloc() {
    bloc = EmployeeBloc();
    bloc.add(GetEmployees());
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return BlocProvider<EmployeeBloc>(
      create: (context) => bloc,
      child: BlocConsumer<EmployeeBloc, EmployeeState>(
        listener: (context, state) {
          if (state is Loading) {
            isShowLoading = true;
          } else if (state is GetEmployeeSuccess) {
            isShowLoading = false;
            if (state.isLoadMore) {
              _refreshController.loadComplete();
              employees.addAll(state.employees);
            } else {
              _refreshController.refreshCompleted();
              employees = state.employees;
            }
            totalShipper = state.totalShipper;
          } else if (state is Error) {
            isShowLoading = false;
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
            ShowDialog(context).showNotification(state.message);
          }
        },
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
    return SmartRefresher(
      footer: BaseWidget.buildFooter(),
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onLoading: () {
        bloc.add(GetEmployees(isLoadMore: true));
      },
      onRefresh: () {
        employees.clear();
        bloc.add(GetEmployees(isRefresh: true));
      },
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
                  gradient:
                      LinearGradient(colors: [Colors.grey[400], Colors.white]),
                  shape: BoxShape.circle),
              child: Image.asset('assets/images/icon_ship.png')),
          SizedBox(
            width: 10,
          ),
          RichText(
            text: TextSpan(
                text: totalShipper.toString(),
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
          itemCount: employees.length,
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
        Navigator.pushNamed(context, AppConst.routeDetailShipper,
            arguments: employees[index]);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.symmetric(vertical: 5),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  height: 60,
                  width: 60,
                  child: employees[index].avatarUrl.isNotEmpty
                      ? Image.network(
                          AppConst.baseImageUrl + employees[index].avatarUrl,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey[400],
                          child: Image.asset(
                            'assets/images/no_avatar.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              // Container(
              //   height: 60,
              //   width: 60,
              //   decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       image: DecorationImage(
              //           image: employees[index].avatarUrl.isNotEmpty
              //               ? Image.network(
              //                   AppConst.baseImageUrl +
              //                       employees[index].avatarUrl,
              //                   height: double.infinity,
              //                   width: double.infinity,
              //                   fit: BoxFit.cover,
              //                 ).image
              //               : Image.asset(
              //                   'assets/images/no_avatar.png',
              //                   fit: BoxFit.cover,
              //                 ).image)),
              // ),
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
                        employees[index].name,
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
                                text: employees[index].phoneNumber,
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
                                text: employees[index].shipArea,
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
                  onPressed: () async {
                    await launch("tel://${employees[index].phoneNumber}");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
