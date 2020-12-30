import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:manage_delivery/base/consts/const.dart';
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
          title: Text('Khách hàng'),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {}),
          ],
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 2,
            );
          },
          itemBuilder: (context, index) {
            return _buildItemCustomer();
          }),
    );
  }

  Widget _buildItemCustomer() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppConst.routeDetailCustomer);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
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
                InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.phone,
                      color: Colors.blue,
                    ))
              ],
            ),
          ),
          RichText(
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
        ],
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
