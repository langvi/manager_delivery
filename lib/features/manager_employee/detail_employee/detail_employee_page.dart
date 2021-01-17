import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/base/view/base_staful_widget.dart';
import 'package:manage_delivery/features/manager_employee/detail_employee/bloc/detail_employee_bloc.dart';
import 'package:manage_delivery/features/manager_employee/model/employee_response.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';
import 'package:manage_delivery/utils/convert_value.dart';
import 'package:manage_delivery/utils/status_product.dart';

class DetailEmployeePage extends StatefulWidget {
  DetailEmployeePage({Key key}) : super(key: key);

  @override
  _DetailEmployeePageState createState() => _DetailEmployeePageState();
}

class _DetailEmployeePageState
    extends BaseStatefulWidgetState<DetailEmployeePage, DetailEmployeeBloc> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  FocusNode _nameFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();
  Employee employee;
  bool isChangeName = false;
  bool isChangePhone = false;
  bool isShowList = false;
  bool isShowGetProduct = true;
  String currentTime = '22/2/2021';
  List<Product> products;
  @override
  void initBloc() {
    bloc = DetailEmployeeBloc();
  }

  @override
  void didChangeDependencies() {
    employee = ModalRoute.of(context).settings.arguments;
    _nameController.text = employee.name;
    _phoneController.text = employee.phoneNumber;
    super.didChangeDependencies();
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return BlocProvider<DetailEmployeeBloc>(
      create: (context) => bloc,
      child: BlocConsumer<DetailEmployeeBloc, DetailEmployeeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.mainColor,
              leading: BackButton(
                onPressed: () => Navigator.pop(context),
              ),
              title: Text('Thông tin nhân viên'),
            ),
            body: _buildBody(),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(),
          _buildInfor(),
          Visibility(
            visible: isShowList,
            child: _buildListProduct(),
          ),
          Visibility(visible: isShowList, child: _buildListProduct())
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      color: Colors.grey,
      child: Image.asset(
        'assets/images/no_avatar.png',
        fit: BoxFit.contain,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.3,
      ),
    );
  }

  Widget _buildInfor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.all(10.0), child: _buildInputName()
            //  Text(
            //   'Ha Van SH',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: RichText(
            text: TextSpan(
                text: 'Vị trí: ',
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text: 'Nhân viên giao hàng',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ]),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _buildInputPhone()),
        SizedBox(
          height: 10,
        ),
        Card(
          color: Colors.orange[200],
          margin: EdgeInsets.symmetric(horizontal: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildItemInfor('Khu vực giao', 'Đống Đa'),
                _buildItemInfor('Số ngày công', '22'),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: Text(
        //     'Công việc',
        //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _buildItemJob(AppColors.gradientGetProduct),
          // child: Row(
          //   children: [
          //     Expanded(
          //         child:
          //             _buildItemJob(AppColors.gradientGetProduct, 'Lấy hàng')),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     Expanded(
          //         child: _buildItemJob(AppColors.gradientShipped, 'Giao hàng')),
          //   ],
          // ),
        )
        // Divider(
        //   thickness: 1,
        // ),
      ],
    );
  }

  Widget _buildItemJob(List<Color> colors) {
    return Card(
      color: Colors.blue[100],
      margin: EdgeInsets.all(0),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Text(
              'Công việc',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: _buildText('Thành công', '20', AppColors.mainColor),
                ),
                Expanded(
                  child: _buildText('Thất bại', '20', Colors.red),
                )
              ],
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isShowList = !isShowList;
                });
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Chi tiết'),
                    SizedBox(width: 5),
                    SizedBox(
                      height: 30,
                      child: Icon(
                        isShowList ? AntDesign.caretdown : AntDesign.caretright,
                        size: 18,
                      ),
                    )
                  ],
                ),
              ),
              // child: Chip(
              //   backgroundColor: Colors.black54,
              //   label: Text(
              //     'Chi tiết',
              //     style: TextStyle(
              //         color: Colors.white,
              //         decoration: TextDecoration.underline),
              //   ),
              // ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildText(String title, String value, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildItemInfor(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(content),
      ],
    );
  }

  Widget _buildInputName() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
              controller: _nameController,
              focusNode: _nameFocus,
              readOnly: !isChangeName,
              onFieldSubmitted: (value) {
                isChangeName = false;
                print(value);
              },
              textInputAction: TextInputAction.done,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: OutlineInputBorder(borderSide: BorderSide.none)
                  // fillColor: Colors.white,
                  // filled: true,
                  )),
        ),
        IconButton(
            icon: Icon(
              Icons.edit,
              color: AppColors.mainColor,
            ),
            onPressed: () {
              setState(() {
                isChangeName = true;
                _nameFocus.requestFocus();
              });
            })
      ],
    );
  }

  Widget _buildInputPhone() {
    return Row(
      children: [
        Text('Số điện thoại: '),
        Expanded(
          child: TextFormField(
              controller: _phoneController,
              focusNode: _phoneFocus,
              readOnly: !isChangePhone,
              onFieldSubmitted: (value) {
                isChangePhone = false;
                print(value);
              },
              textInputAction: TextInputAction.done,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: OutlineInputBorder(borderSide: BorderSide.none))),
        ),
        IconButton(
            icon: Icon(
              Icons.edit,
              color: AppColors.mainColor,
            ),
            onPressed: () {
              setState(() {
                isChangePhone = true;
                _phoneFocus.requestFocus();
              });
            })
      ],
    );
  }

  Widget _buildListProduct() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
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
                        Expanded(
                          child: RichText(
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
                        const SizedBox(width: 5),
                        Text(convertDateTimeToDay(products[index].createdAt)),
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
                          Text(convertDateTimeToHour(products[index].createdAt))
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
                        Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: getColor(
                                    products[index].statusShip,
                                    products[index].isSuccess,
                                    products[index].isEnter)),
                            child: Text(
                              getStatusOfProduct(
                                  products[index].statusShip,
                                  products[index].isSuccess,
                                  products[index].isEnter),
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
