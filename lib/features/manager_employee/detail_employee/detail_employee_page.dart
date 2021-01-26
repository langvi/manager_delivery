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
import 'package:manage_delivery/utils/dialog.dart';
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

  DateTime currentTime;
  // String currentTime = '22/2/2021';
  List<Product> products = [];
  @override
  void initBloc() {
    bloc = DetailEmployeeBloc();
    currentTime = DateTime.now();
  }

  @override
  void didChangeDependencies() {
    if (employee == null) {
      employee = ModalRoute.of(context).settings.arguments;
      DateTime currentTime = DateTime.now();
      bloc.add(GetProductOfEmployee(
          employee.id,
          DateTime(currentTime.year, currentTime.month, currentTime.day),
          DateTime(currentTime.year, currentTime.month, currentTime.day + 1)));
      _nameController.text = employee.name;
      _phoneController.text = employee.phoneNumber;
    }

    super.didChangeDependencies();
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return BlocProvider<DetailEmployeeBloc>(
      create: (context) => bloc,
      child: BlocConsumer<DetailEmployeeBloc, DetailEmployeeState>(
        listener: (context, state) {
          if (state is Loading) {
            isShowLoading = true;
          } else if (state is UpdateSuccess) {
            isShowLoading = false;
            isChangeName = false;
          } else if (state is GetProductSuccess) {
            isShowLoading = false;
            products = state.products;
          } else if (state is Error) {
            isShowLoading = false;
            ShowDialog(context)
                .showNotification('Có lỗi xảy ra \n Xin vui lòng thử lại sau');
          }
        },
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
          const SizedBox(
            height: 10,
          ),
          Visibility(visible: isShowList, child: _buildListProduct())
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      color: Colors.grey[300],
      child: employee.avatarUrl.isNotEmpty
          ? Image.network(
              AppConst.baseImageUrl + employee.avatarUrl,
              fit: BoxFit.contain,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
            )
          : Image.asset(
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
          color: Colors.blue[100],
          margin: EdgeInsets.symmetric(horizontal: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildItemInfor('Khu vực giao', employee.shipArea),
                _buildItemInfor('Số ngày công', employee.dayWork.toString()),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _buildItemJob(AppColors.gradientGetProduct),
        )
      ],
    );
  }

  Widget _buildItemJob(List<Color> colors) {
    return Card(
      color: Colors.blue[100],
      margin: EdgeInsets.all(0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Số đơn giao: ${products.length}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(convertDateTimeToDay(currentTime)),
                IconButton(
                    icon: Icon(
                      FontAwesome.calendar,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1900, 1, 1),
                          maxTime: DateTime(2030, 12, 31),
                          theme: DatePickerTheme(
                              headerColor: AppColors.mainColor,
                              backgroundColor: Colors.white,
                              cancelStyle: TextStyle(
                                  color: Color(0xfff6fadc), fontSize: 16),
                              itemStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              doneStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          onConfirm: (date) {
                        bloc.add(GetProductOfEmployee(
                            employee.id,
                            DateTime(date.year, date.month, date.day),
                            DateTime(date.year, date.month, date.day + 1)));
                        setState(() {
                          currentTime = date;
                        });
                      }, currentTime: currentTime, locale: LocaleType.vi);
                    })
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: _buildText(
                      'Thành công', getSuccess(), AppColors.mainColor),
                ),
                Expanded(
                  child: _buildText('Thất bại', getFailure(), Colors.red),
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
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
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
                if (value.isNotEmpty) {
                  employee.name = value;
                  bloc.add(UpdateShipper(employee));
                } else {
                  ShowDialog(context)
                      .showNotification('Tên không được để trống');
                }
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
              keyboardType: TextInputType.phone,
              readOnly: !isChangePhone,
              onFieldSubmitted: (value) {
                if (value.isNotEmpty) {
                  employee.phoneNumber = value;
                  bloc.add(UpdateShipper(employee));
                } else {
                  ShowDialog(context)
                      .showNotification('Số điện thoại không được để trống');
                }
                isChangePhone = false;
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
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
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

  String getSuccess() {
    int success = 0;
    products.forEach((element) {
      if (element.status == 2 || element.status == 6) {
        success++;
      }
    });
    return success.toString();
  }

  String getFailure() {
    int failure = 0;
    products.forEach((element) {
      if (element.status == 3 || element.status == 5) {
        failure++;
      }
    });
    return failure.toString();
  }
}
