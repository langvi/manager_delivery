import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/view/base_staful_widget.dart';
import 'package:manage_delivery/features/manager_customer/detail_customer/bloc/detail_customer_bloc.dart';

class DetailCustomerPage extends StatefulWidget {
  const DetailCustomerPage({Key key}) : super(key: key);

  @override
  _DetailCustomerPageState createState() => _DetailCustomerPageState();
}

class _DetailCustomerPageState
    extends BaseStatefulWidgetState<DetailCustomerPage, DetailCustomerBloc> {
  @override
  void initBloc() {
    bloc = DetailCustomerBloc();
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return BlocProvider<DetailCustomerBloc>(
      create: (context) => bloc,
      child: BlocConsumer<DetailCustomerBloc, DetailCustomerState>(
        listener: (context, state) {},
        builder: (context, state) {
          return baseShowLoading(
              child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: AppColors.mainColor,
              leading: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text('Thông tin khách hàng'),
              actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfor(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Danh sách đơn hàng',
              style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _buildListProduct()
        ],
      ),
    );
  }

  Widget _buildInfor() {
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
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
                Text(
                  'SDHSJDS',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.blue[700],
                        Colors.blue,
                        Colors.blue[300]
                      ]),
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.phone,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '0254879631',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.green[700],
                        Colors.green,
                        Colors.green[300]
                      ]),
                      shape: BoxShape.circle),
                  child: Icon(
                    Entypo.address,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '30 Vân Canh, Hoài Đức, Hà Nội',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              ],
            ),
            Divider(thickness: 1),
            SizedBox(
              height: 10,
            ),
            _buildInforProduct()
          ],
        ),
      ),
    );
  }

  Widget _buildInforProduct() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildItemInfor('Đã tạo', 45, Colors.orange),
        _buildItemInfor('Đang lấy hàng', 10, Colors.green),
        _buildItemInfor('Đang giao', 5, Colors.blue),
        _buildItemInfor('Đã giao', 30, AppColors.mainColor),
      ],
    );
  }

  Widget _buildItemInfor(String title, int value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
        Text(
          '$value',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildListProduct() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          // return ListTile(title: Text(products[index].nameProduct));
          return _buildItemProduct(index);
        },
      ),
    );
  }

  Widget _buildItemProduct(int index) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppConst.routeDetailProduct);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.blue[700], Colors.blue[300]]),
                      shape: BoxShape.circle),
                  child: SvgPicture.asset(
                    'assets/images/product.svg',
                    height: 40,
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'Mã đơn hàng: ',
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: '5efefe5',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                        Text('20/12/2021'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Người gửi: ',
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: 'Hoa',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                          Text('12:02')
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                                text: 'Địa chỉ: ',
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: 'Hoa Bằng, Cầu Giấy, Hà Nội',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue),
                            child: Text(
                              'fefe',
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
