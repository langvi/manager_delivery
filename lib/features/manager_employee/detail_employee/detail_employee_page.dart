import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/view/base_staful_widget.dart';
import 'package:manage_delivery/features/manager_employee/detail_employee/bloc/detail_employee_bloc.dart';

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
  bool isChangeName = false;
  bool isChangePhone = false;
  bool isShowList = false;
  bool isShowGetProduct = true;
  String currentTime = '22/2/2021';
  @override
  void initBloc() {
    bloc = DetailEmployeeBloc();
    _nameController.text = 'Ha Van SH';
    _phoneController.text = '01233214856';
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return BlocProvider<DetailEmployeeBloc>(
      create: (context) => bloc,
      child: BlocConsumer<DetailEmployeeBloc, DetailEmployeeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            // backgroundColor: Colors.grey,
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
            child: _buildTitleProduct(
                isShowGetProduct ? 'Danh sách đơn lấy' : 'Danh sách đơn giao'),
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
            child: _buildInputPhone()
            //  RichText(
            //   text: TextSpan(
            //       text: 'Số điện thoại: ',
            //       style: TextStyle(color: Colors.black, fontSize: 16),
            //       children: [
            //         TextSpan(
            //           text: '0214578963',
            //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            //         )
            //       ]),
            // ),
            ),
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
                Expanded(child: _buildItemInfor('Số CMTND', '0236598741')),
                Expanded(child: _buildItemInfor('Khu vực giao', 'Đống Đa')),
                Expanded(child: _buildItemInfor('Số ngày công', '22')),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Công việc',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                  child:
                      _buildItemJob(AppColors.gradientGetProduct, 'Lấy hàng')),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: _buildItemJob(AppColors.gradientShipped, 'Giao hàng')),
            ],
          ),
        )
        // Divider(
        //   thickness: 1,
        // ),
      ],
    );
  }

  Widget _buildItemJob(List<Color> colors, String title) {
    return Card(
      color: Colors.blue[100],
      margin: EdgeInsets.all(0),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: colors),
                  borderRadius: BorderRadius.circular(10)),
              child: SvgPicture.asset(
                'assets/images/product.svg',
                height: 40,
              ),
            ),
            Text(title),
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
                decoration: BoxDecoration(color: Colors.grey[300]),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Chi tiết'),
                    SizedBox(width: 5),
                    SizedBox(
                      height: 30,
                      child: Icon(
                        isShowList ? AntDesign.caretdown : AntDesign.caretright,
                        size: 20,
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
          padding: EdgeInsets.all(3),
          // color: color,
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
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

  Widget _buildTitleProduct(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(currentTime),
          IconButton(
              icon: Icon(
                Icons.date_range,
                color: AppColors.mainColor,
                size: 26,
              ),
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2010, 1, 1),
                    maxTime: DateTime(2025, 6, 7), onConfirm: (date) {
                  setState(() {
                    currentTime = DateFormat('dd/MM/yyy').format(date);
                  });
                  // print('confirm $date');
                }, currentTime: DateTime.now(), locale: LocaleType.vi);
              })
        ],
      ),
    );
  }
}
