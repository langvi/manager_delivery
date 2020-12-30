import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/view/base_staful_widget.dart';
import 'package:manage_delivery/features/manager_product/detail_product/bloc/detail_product_bloc.dart';
import 'package:manage_delivery/utils/convert_value.dart';

class DetailProductPage extends StatefulWidget {
  DetailProductPage({Key key}) : super(key: key);

  @override
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState
    extends BaseStatefulWidgetState<DetailProductPage, DetailProductBloc> {
  @override
  void initBloc() {
    bloc = DetailProductBloc();
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
              leading: BackButton(
                onPressed: () => Navigator.pop(context),
              ),
              title: Text('Chi tiết đơn hàng'),
              actions: [
                _popUpMenu()
                // IconButton(
                //     icon: Icon(
                //       Icons.more_vert_outlined,
                //       color: Colors.white,
                //     ),
                //     onPressed: () {})
              ],
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
            _buildSend(true),
            Divider(
              thickness: 2,
            ),
            _buildSend(false),
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
                    text: 'AJJHS',
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
                      text: '0123546987',
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
                    text: '30 Vân Canh, Hoài Đức, Hà Nội',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ]),
          ),
        ),
      ],
    );
  }

  Widget _buildSend(bool isSend) {
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
                      text: 'Lăng Vĩ',
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
                    text: '0123456789',
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
                      text: '30 Vân Canh, Hoài Đức, Hà Nội',
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
                'dssd115454ds5'.toUpperCase(),
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
              'Ao khoac',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Thời gian tạo:'),
              Text(
                convertDateTimeToString(DateTime.now()),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Phí ship:'),
            Text(
              convertMoney(22000),
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
                convertMoney(122000),
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
                'Quần áo',
                textAlign: TextAlign.end,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _popUpMenu() {
    return PopupMenuButton(onSelected: (value) {
      if (value == 1) {
        print('Cap nhat');
      } else {
        print('Xóa');
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
      list.add(
        PopupMenuDivider(
          height: 10,
        ),
      );
      list.add(
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Xóa đơn hàng",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      );
      return list;
    });
  }
}
