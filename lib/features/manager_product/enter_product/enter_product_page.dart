import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/utils/input_text.dart';
import 'package:manage_delivery/utils/scan_qr.dart';

class EnterProductPage extends StatefulWidget {
  EnterProductPage({Key key}) : super(key: key);

  @override
  _EnterProductPageState createState() => _EnterProductPageState();
}

class _EnterProductPageState extends State<EnterProductPage> {
  TextEditingController _controller = TextEditingController();
  String productId;
  @override
  Widget build(BuildContext context) {
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
                  controller: _controller)),
          IconButton(
              icon: Icon(AntDesign.qrcode),
              onPressed: () async {
                productId = await scanQRcode();
                if (productId != null) {
                  setState(() {
                    _controller.text = productId;
                  });
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
        itemCount: 3,
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
