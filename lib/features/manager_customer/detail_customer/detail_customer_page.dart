import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text('Chi tiết khách hàng'),
            ),
            body: _buildBody(),
          ));
        },
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfor(),
          Divider(
            thickness: 2,
          ),
          Text(
            'Danh sách đơn hàng',
            style: TextStyle(
                color: AppColors.mainColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: _buildListProduct())
        ],
      ),
    );
  }

  Widget _buildInfor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin khách hàng',
          style: TextStyle(
              color: AppColors.mainColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: RichText(
            text: TextSpan(
                text: 'Mã khách hàng: ',
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: '15522',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ]),
          ),
        ),
        RichText(
          text: TextSpan(
              text: 'Tên: ',
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: 'ÂHHĐ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: RichText(
            text: TextSpan(
                text: 'Số điện thoại: ',
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: '0124587963',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ]),
          ),
        ),
        RichText(
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
      ],
    );
  }

  Widget _buildListProduct() {
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey,
        );
      },
      itemBuilder: (context, index) {
        // return ListTile(title: Text(products[index].nameProduct));
        return _buildItemProduct(index);
      },
    );
  }

  Widget _buildItemProduct(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppConst.routeDetailProduct);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mã đơn hàng: 5efefe5',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('20/12/2021'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text('Người gửi: fefe'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Địa chỉ: fefefe'),
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
    );
  }
}
