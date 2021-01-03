import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/view/base_widget.dart';
import 'package:manage_delivery/utils/dropdown_widget.dart';
import 'package:manage_delivery/utils/input_text.dart';

class CustomerPage extends StatefulWidget {
  CustomerPage({Key key}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  TextEditingController searchController = TextEditingController();
  ScrollController controller = ScrollController();
  bool isShowInfor = true;
  String currentValue = '';
  List<String> values = ['Tất cả', 'Đống Đa'];
  @override
  void initState() {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            style: TextStyle(fontSize: isShowInfor ? 14 : 18),
                          ),
                          Spacer(),
                          IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () {}),
                          // IconButton(
                          //     icon: Icon(
                          //       MaterialCommunityIcons.filter_variant,
                          //       color: Colors.white,
                          //       size: 20,
                          //     ),
                          //     onPressed: () {}),
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
                                    gradient: LinearGradient(
                                        colors: [Colors.red, Colors.orange]),
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
                                  text: '100',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text: '\nKhách hàng',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ]),
                            ),
                            Spacer(),
                            Container(
                                height: 30,
                                width: 100,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Chọn khu vực',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  underline: Container(),
                                  value: currentValue.isEmpty
                                      ? null
                                      : currentValue,
                                  dropdownColor: AppColors.mainColor,
                                  style: TextStyle(color: Colors.white),
                                  iconEnabledColor: Colors.white,
                                  onChanged: (value) {
                                    setState(() {
                                      currentValue = value;
                                    });
                                  },
                                  items: values.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    );
                                  }).toList(),
                                ))
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
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return _buildItemCustomer();
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchInput() {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Danh sách khách hàng'.toUpperCase(),
              style: TextStyle(color: AppColors.mainColor, fontSize: 18),
            )),
        Spacer(),
        IconButton(icon: Icon(Icons.search), onPressed: () {})
      ],
    );
  }

  Widget _buildItemCustomer() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppConst.routeDetailCustomer);
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
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.red, Colors.orange]),
                    shape: BoxShape.circle),
                child: Icon(
                  MaterialIcons.person,
                  color: Colors.white,
                  size: 34,
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
                                text: 'SDSS',
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
                            text: 'Địa chỉ: ',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: '23 Mạc Thái Tông, Cầu Giấy, Hà Nội',
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
                  onTap: () {},
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
}
