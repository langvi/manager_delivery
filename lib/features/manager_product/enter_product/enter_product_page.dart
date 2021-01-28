import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/view/base_staful_widget.dart';
import 'package:manage_delivery/features/manager_product/enter_product/bloc/enter_bloc.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';
import 'package:manage_delivery/utils/convert_value.dart';
import 'package:manage_delivery/utils/dialog.dart';
import 'package:manage_delivery/utils/input_text.dart';
import 'package:manage_delivery/utils/scan_qr.dart';
import 'package:manage_delivery/utils/status_product.dart';

class EnterProductPage extends StatefulWidget {
  EnterProductPage({Key key}) : super(key: key);

  @override
  _EnterProductPageState createState() => _EnterProductPageState();
}

class _EnterProductPageState
    extends BaseStatefulWidgetState<EnterProductPage, EnterBloc> {
  TextEditingController _controller = TextEditingController();
  String productId;
  List<Product> products = [];
  @override
  void initBloc() {
    bloc = EnterBloc();
  }

  @override
  Widget buildWidgets(BuildContext context) {
    sortByTime();
    return BlocProvider<EnterBloc>(
      create: (context) => bloc,
      child: BlocConsumer<EnterBloc, EnterState>(
        listener: (context, state) {
          if (state is EnterSuccess) {
            products.add(state.product);
          } else if (state is Error) {
            ShowDialog(context).showNotification(state.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.mainColor,
              leading: BackButton(
                onPressed: () => Navigator.pop(context),
              ),
              title: Text('Nhập đơn hàng'),
            ),
            body: _buildBody(),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [_buildInput(), _buildListProduct()],
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
              child: BuildTextInput(
                  filledColor: Colors.grey[300],
                  hintText: 'Nhập mã đơn hàng',
                  textInputType: TextInputType.number,
                  iconNextTextInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(7)
                  ],
                  submitFunc: () {
                    if (_controller.text.isNotEmpty) {
                      productId = _controller.text;
                      bloc.add(EnterProduct(productId));
                    }
                  },
                  controller: _controller)),
          IconButton(
              icon: Icon(AntDesign.qrcode),
              onPressed: () async {
                productId = await scanQRcode();
                if (productId != null) {
                  bloc.add(EnterProduct(productId));
                }
              })
        ],
      ),
    );
  }

  Widget _buildListProduct() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) {
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
          // Navigator.pushNamed(context, AppConst.routeDetailProduct);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: getGradient(
                        products[index].status,
                      )),
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
                        Expanded(
                          child: RichText(
                            // overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                                text: 'Mã đơn hàng: ',
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: products[index].id,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(convertDateTimeToDay(products[index].enterAt)),
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
                                    text: products[index].sendFrom,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                          Text(convertDateTimeToHour(products[index].enterAt))
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
                                    text: products[index].addressReceive,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: getColor(
                                  products[index].status,
                                )),
                            child: Text(
                              getStatusOfProduct(
                                products[index].status,
                              ),
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

  void sortByTime() {
    products.sort((value1, value2) {
      return value2.enterAt.compareTo(value1.enterAt);
    });
  }
}
