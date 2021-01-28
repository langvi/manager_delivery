import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/view/base_staful_widget.dart';
import 'package:manage_delivery/features/manager_product/detail_product/bloc/detail_product_bloc.dart';
import 'package:manage_delivery/features/manager_product/model/infor_response.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';
import 'package:manage_delivery/utils/convert_value.dart';
import 'package:manage_delivery/utils/status_product.dart';

class DetailProductPage extends StatefulWidget {
  DetailProductPage({Key key}) : super(key: key);

  @override
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState
    extends BaseStatefulWidgetState<DetailProductPage, DetailProductBloc> {
  Product product;
  CustomerProduct customer;
  @override
  void initBloc() {
    bloc = DetailProductBloc();
  }

  @override
  void didChangeDependencies() {
    Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;
    product = data['product'];
    customer = data['inforCus'];
    super.didChangeDependencies();
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return BlocProvider<DetailProductBloc>(
      create: (context) => bloc,
      child: BlocConsumer<DetailProductBloc, DetailProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.mainColor,
              leading: BackButton(
                onPressed: () => Navigator.pop(context),
              ),
              title: Text('Chi tiết đơn hàng'),
              actions: [_popUpMenu()],
            ),
            body: _buildBody(),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            _buildHearder(),
            Divider(
              thickness: 2,
            ),
            // dia chi giao hang
            _buildSend(true, product.receiveBy, product.phoneReceive,
                product.addressReceive),
            Divider(
              thickness: 2,
            ),
            _buildSend(false, product.sendFrom, product.phoneSend,
                product.addressSend),
            Divider(
              thickness: 2,
            ),
            _buildInfor()
          ],
        ),
      ),
    );
  }

  Widget _buildHearder() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
                text: 'Tên shop: ',
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: customer.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                  text: 'Số điện thoại: ',
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: customer.phone,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ]),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
                text: 'Địa chỉ: ',
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: customer.address,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ]),
          ),
        ),
      ],
    );
  }

  Widget _buildSend(
      bool isSend, String name, String phoneNumber, String address) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isSend ? 'Địa chỉ giao hàng' : 'Địa chỉ lấy hàng',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: RichText(
              text: TextSpan(
                  text: 'Họ và tên: ',
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ]),
            ),
          ),
          RichText(
            text: TextSpan(
                text: 'Số điện thoại: ',
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: phoneNumber,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: RichText(
              text: TextSpan(
                  text: 'Địa chỉ: ',
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: address,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfor() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Thông tin đơn hàng',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mã đơn hàng:'),
              Text(
                product.id.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tên đơn hàng:'),
            Text(
              product.nameProduct,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _buildStatus(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Thời gian tạo:'),
            Text(
              convertDateTimeToString(product.createdAt),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _getTimeShipped(product.status),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Phí ship:'),
            Text(
              convertMoney(product.costShip),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Thu hộ:'),
              Text(
                convertMoney(product.costProduct),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Ghi chú:'),
            Expanded(
              child: Text(
                product.note ?? 'Không có',
                textAlign: TextAlign.end,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _getTimeShipped(int status) {
    if (status == 6) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Thời gian giao:'),
          Text(
            convertDateTimeToString(product.shipedAt),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          // Visibility(
          //   visible: status > 3,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text('Thời gian tạo:'),
          //       Text(
          //         convertDateTimeToString(product.createdAt),
          //         style: TextStyle(fontWeight: FontWeight.bold),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Thời gian nhập:'),
              Text(
                product.enterAt != null
                    ? convertDateTimeToString(product.enterAt)
                    : 'Chưa nhập',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      );
    }
  }

  Widget _buildStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Trạng thái:'),
        Text(
          getStatusOfProduct(
            product.status,
          ),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _popUpMenu() {
    return PopupMenuButton(onSelected: (value) {
      if (value == 1) {
        if (getStatusOfProduct(
              product.status,
            ) !=
            'Đã giao') {
          Navigator.pushNamed(context, AppConst.routeUpdateProduct,
              arguments: product);
        }
      }
    }, itemBuilder: (context) {
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
              Text("Cập nhật đơn hàng"),
            ],
          ),
        ),
      );
      return list;
    });
  }
}
