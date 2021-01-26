import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/view/base_staful_widget.dart';
import 'package:manage_delivery/base/view/base_widget.dart';
import 'package:manage_delivery/features/manager_customer/bloc/customer_bloc.dart';
import 'package:manage_delivery/features/manager_customer/model/customer_response.dart';
import 'package:manage_delivery/utils/convert_value.dart';
import 'package:manage_delivery/utils/dialog.dart';
import 'package:manage_delivery/utils/search.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerPage extends StatefulWidget {
  CustomerPage({Key key}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState
    extends BaseStatefulWidgetState<CustomerPage, CustomerBloc> {
  TextEditingController searchController = TextEditingController();
  ScrollController controller = ScrollController();
  ScrollController scrollCustomer = ScrollController();
  final _refreshController = RefreshController();
  bool isShowInfor = true;
  String currentValue = '';
  int totalCustomer = 0;
  List<Customer> customers = [];
  List<String> values = [
    'Tất cả',
    'Đống Đa',
    'Thanh Xuân',
    'Nam Từ Liêm',
    'Cầu Giấy',
    'Hai Bà Trưng',
    'Hoàng Mai'
  ];
  @override
  void initBloc() {
    bloc = CustomerBloc();
    bloc.add(GetAllCustomer());
    controller.addListener(() {
      if (controller.position.pixels > 30) {
        setState(() {
          isShowInfor = false;
        });
      } else {
        setState(() {
          isShowInfor = true;
        });
      }
    });
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return BlocProvider<CustomerBloc>(
      create: (context) => bloc,
      child: BlocConsumer<CustomerBloc, CustomerState>(
        listener: (context, state) {
          if (state is Loading) {
            isShowLoading = true;
          } else if (state is GetCustomerSuccess) {
            isShowLoading = false;
            if (state.isLoadMore) {
              customers.addAll(state.customers);
              _refreshController.loadComplete();
            } else {
              customers = state.customers;
              _refreshController.refreshCompleted();
            }
            totalCustomer = state.totalCustomer;
          } else if (state is Error) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
            isShowLoading = false;
            ShowDialog(context).showNotification(state.message);
          }
        },
        builder: (context, state) {
          return baseShowLoading(
            child: Scaffold(
              backgroundColor: AppColors.backGround,
              body: NestedScrollView(
                  controller: controller,
                  headerSliverBuilder: (context, isScroll) {
                    return [
                      SliverAppBar(
                        expandedHeight: 150,
                        floating: false,
                        pinned: true,
                        automaticallyImplyLeading: false,
                        flexibleSpace: FlexibleSpaceBar(
                          titlePadding: EdgeInsets.only(left: 20),
                          centerTitle: true,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Quản lí khách hàng',
                                    style: TextStyle(
                                        fontSize: isShowInfor ? 14 : 18),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      icon: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        showSearch(
                                            context: context,
                                            delegate: CustomSearchDelegate(
                                                callbackFind: (value) {
                                              bloc.add(FindCustomer(value));
                                              setState(() {
                                                currentValue = '';
                                              });
                                            }));
                                      }),
                                ],
                              ),
                              Visibility(
                                visible: isShowInfor,
                                child: SizedBox(
                                  height: 10,
                                ),
                              ),
                              Visibility(
                                visible: isShowInfor,
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Colors.red,
                                              Colors.orange
                                            ]),
                                            shape: BoxShape.circle),
                                        child: Icon(
                                          Icons.people,
                                          color: Colors.white,
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: totalCustomer.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          children: [
                                            TextSpan(
                                              text: '\nKhách hàng',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )
                                          ]),
                                    ),
                                    Spacer(),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                          height: 40,
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            hint: Text(
                                              'Chọn khu vực',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                            underline: Container(),
                                            value: currentValue.isEmpty
                                                ? null
                                                : currentValue,
                                            dropdownColor: AppColors.mainColor,
                                            style:
                                                TextStyle(color: Colors.white),
                                            iconEnabledColor: Colors.white,
                                            onChanged: (value) {
                                              setState(() {
                                                currentValue = value;
                                              });
                                              bloc.add(GetCustomerArea(
                                                  convertNameToAreaId(
                                                      currentValue)));
                                            },
                                            items: values
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                              );
                                            }).toList(),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: isShowInfor,
                                child: SizedBox(
                                  height: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                        backgroundColor: AppColors.mainColor,
                      ),
                    ];
                  },
                  body: _buildBody()),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SmartRefresher(
        controller: _refreshController,
        scrollController: scrollCustomer,
        enablePullDown: true,
        footer: BaseWidget.buildFooter(),
        enablePullUp: true,
        onRefresh: () {
          bloc.add(GetAllCustomer(isRefresh: true));
        },
        onLoading: () {
          bloc.add(GetAllCustomer(isLoadMore: true));
        },
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    return _buildItemCustomer(index);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCustomer(int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppConst.routeDetailCustomer,
              arguments: customers[index]);
        },
        child: Container(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Container(
                padding: EdgeInsets.all(5),
                // decoration: BoxDecoration(
                //     gradient:
                //         LinearGradient(colors: [Colors.red, Colors.orange]),
                //     shape: BoxShape.circle),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                      backgroundColor: Colors.orange[300],
                      child: customers[index].avatarUrl.isNotEmpty
                          ? Image.network(
                              customers[index].avatarUrl,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Text(
                              getAvatarName(customers[index].name),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))
                      // : Icon(
                      //     Icons.person,
                      //   ),
                      ),
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
                      child: RichText(
                        text: TextSpan(
                            text: 'Tên shop: ',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: customers[index].name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ]),
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
                                text: customers[index].phoneNumber,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: RichText(
                        text: TextSpan(
                            text: 'Địa chỉ: ',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: customers[index].address,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () async {
                    await launch("tel://${customers[index].phoneNumber}");
                  },
                  child: Icon(
                    Icons.phone,
                    color: Colors.blue,
                  )),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _popUpMenu() {
    return PopupMenuButton(
        onSelected: (value) {},
        itemBuilder: (context) {
          var list = List<PopupMenuEntry<Object>>();
          list.add(
            PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  Icon(
                    Entypo.edit,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Cập nhật thông tin"),
                ],
              ),
            ),
          );
          return list;
        });
  }

  String getAvatarName(String name) {
    return name[0];
  }
}
