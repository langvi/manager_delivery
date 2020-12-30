import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/view/base_staful_widget.dart';
import 'package:manage_delivery/features/manager_product/address/bloc/address_bloc.dart';
import 'package:manage_delivery/utils/input_text.dart';
import 'package:manage_delivery/utils/style_text.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState
    extends BaseStatefulWidgetState<AddressPage, AddressBloc> {
  TextEditingController nameReceiveController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController detailAddressCtr = TextEditingController();
  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  String title = 'Thêm địa chỉ người';
  String enterName = 'Nhập tên người';
  bool isSend = true;
  List<String> provinces = ['Hà Nội', 'Lạng Sơn', 'Bắc Ninh', 'Thái Nguyên'];
  @override
  void initBloc() {
    bloc = AddressBloc();
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return baseShowLoading(
        child: BlocProvider<AddressBloc>(
      create: (context) => bloc,
      child: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: BackButton(
                color: Colors.black,
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                getTitle(title),
                style: StyleText.appBarStyle,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Địa chỉ giao hàng',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: BuildTextInput(
                          hintText: getTitle(enterName),
                          controller: nameReceiveController,
                          currentNode: _nameFocus,
                          nextNode: _phoneFocus,
                          isBorder: true,
                          filledColor: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: BuildTextInput(
                          hintText: 'Nhập số điện thoại',
                          controller: phoneController,
                          currentNode: _phoneFocus,
                          obscureText: true,
                          isBorder: true,
                          filledColor: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: _buildDropDown('Chọn tỉnh', ['Hà Nội'])),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: _buildDropDown(
                                  'Chọn quận(huyện)', ['Hai Bà Trưng'])),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: _buildDropDown('Chọn phường(xã)', ['Bách Khoa']),
                      ),
                      TextFormField(
                        controller: detailAddressCtr,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        style: TextStyle(fontSize: 19),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: const EdgeInsets.only(
                                left: 5, right: 5, top: 10, bottom: 10),
                            hintText: 'Nhập địa chỉ chi tiết',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 14)),
                      )
                    ],
                  ),
                  Positioned(
                      left: 0, right: 0, bottom: 5, child: _buildButton())
                ],
              ),
            ),
          );
        },
      ),
    ));
  }

  Widget _buildDropDown(String title, List<String> listAddress) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(title),
        underline: Container(),
        value: null,
        onChanged: (newValue) {
          setState(() {});
        },
        items: listAddress.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      height: 50,
      child: RaisedButton(
        color: AppColors.mainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          setState(() {
            isSend = false;
          });
          // Navigator.pushNamed(context, AppConst.routeCreateAddress);
        },
        child: Text(
          isSend ? 'TIẾP TỤC' : 'LƯU',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  String getTitle(String content) {
    return isSend ? content + ' gửi' : content + ' nhận';
  }
}
