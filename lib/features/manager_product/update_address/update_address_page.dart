import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/view/base_staful_widget.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';
import 'package:manage_delivery/features/manager_product/update_address/bloc/update_address_bloc.dart';
import 'package:manage_delivery/utils/address.dart';
import 'package:manage_delivery/utils/dialog.dart';
import 'package:manage_delivery/utils/input_text.dart';
import 'package:manage_delivery/utils/style_text.dart';
import 'package:manage_delivery/utils/validator.dart';

class UpdateAddressPage extends StatefulWidget {
  UpdateAddressPage({Key key}) : super(key: key);

  @override
  _UpdateAddressPageState createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState
    extends BaseStatefulWidgetState<UpdateAddressPage, UpdateAddressBloc> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController detailAddressCtr = TextEditingController();
  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  String title = 'Thêm địa chỉ người';
  List<String> districs = [
    'Đống Đa',
    'Thanh Xuân',
    'Nam Từ Liêm',
    'Cầu Giấy',
    'Hai Bà Trưng',
    'Hoàng Mai',
  ];
  String enterName = 'Nhập tên người';
  String currentProvince;
  String currentDistrict;
  String currentVillage;
  bool isSend = true;
  // List<String> provinces = ['Hà Nội', 'Lạng Sơn', 'Bắc Ninh', 'Thái Nguyên'];
  Product product;
  final _formKey = GlobalKey<FormState>();
  @override
  void initBloc() {
    bloc = UpdateAddressBloc();
  }

  @override
  void didChangeDependencies() {
    if (product == null) {
      product = ModalRoute.of(context).settings.arguments;
      nameController.text = product.sendFrom;
      phoneController.text = product.phoneSend;
      detailAddressCtr.text = getAddressUpdate(product.addressSend);
      currentProvince = 'Hà Nội';
      currentDistrict = getDistrict(product.addressSend);
      currentVillage = getVillage(product.addressSend);
    }
    super.didChangeDependencies();
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return BlocProvider<UpdateAddressBloc>(
      create: (context) => bloc,
      child: BlocConsumer<UpdateAddressBloc, UpdateAddressState>(
        listener: (context, state) {
          if (state is Loading) {
            isShowLoading = true;
          } else if (state is Success) {
            isShowLoading = false;
            ShowDialog(context).showNotification('Cập nhật thành công',
                functionCloseDialog: () {
              Navigator.pop(context);
              Navigator.pop(context);
            });
          } else if (state is Error) {
            isShowLoading = false;
          }
        },
        builder: (context, state) {
          return baseShowLoading(
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AppColors.mainColor,
                leading: BackButton(
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  getTitle(title),
                  style: StyleText.appBarStyle,
                ),
                centerTitle: true,
              ),
              body: Form(
                key: _formKey,
                child: Column(
                  children: [Expanded(child: _buildBody()), _buildButton()],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
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
                controller: nameController,
                currentNode: _nameFocus,
                nextNode: _phoneFocus,
                isBorder: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Tên người gửi không được để trống';
                  }
                  return null;
                },
                filledColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: BuildTextInput(
                hintText: 'Nhập số điện thoại',
                controller: phoneController,
                currentNode: _phoneFocus,
                textInputType: TextInputType.number,
                isBorder: true,
                validator: (value) {
                  if (isInvalidTextInput(value, CheckValidation.PHONE)) {
                    return 'Số điện thoại phải có 10 chữ số';
                  }
                  return null;
                },
                filledColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(child: _buildDropDown('Chọn tỉnh', ['Hà Nội'], 0)),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: _buildDropDown('Chọn quận(huyện)', districs, 1)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: _buildDropDown('Chọn phường(xã)',
                  Address.fromJson(currentDistrict).villages, 2),
            ),
            TextFormField(
              controller: detailAddressCtr,
              keyboardType: TextInputType.multiline,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Địa chỉ không được để trống';
                }
                return null;
              },
              maxLines: 3,
              style: TextStyle(fontSize: 19),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.only(
                      left: 5, right: 5, top: 10, bottom: 10),
                  hintText: 'Nhập địa chỉ chi tiết',
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 14)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDropDown(String title, List<String> listAddress, int type) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(title),
        underline: Container(),
        value: getValue(type),
        onChanged: (newValue) {
          setState(() {
            switch (type) {
              case 0:
                currentProvince = newValue;
                break;
              case 1:
                currentDistrict = newValue;
                currentVillage = null;
                break;
              case 2:
                currentVillage = newValue;

                break;
              default:
            }
          });
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        width: double.infinity,
        child: RaisedButton(
          color: AppColors.mainColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              if (isValidAddress()) {
                if (isSend) {
                  product.addressSend = getAddress();
                  product.phoneSend = phoneController.text;
                  product.sendFrom = nameController.text;
                  nameController.text = product.receiveBy;
                  phoneController.text = product.phoneReceive;
                  detailAddressCtr.text =
                      getAddressUpdate(product.addressReceive);
                } else {
                  product.addressReceive = getAddress();
                  product.phoneReceive = phoneController.text;
                  product.receiveBy = nameController.text;
                  bloc.add(UpdateProduct(product));
                }
                setState(() {
                  isSend = false;
                  nameController.text = product.receiveBy;
                  phoneController.text = product.phoneReceive;
                  // detailAddressCtr.text = product.addressReceive;
                });
              }
            }
          },
          child: Text(
            isSend ? 'TIẾP TỤC' : 'LƯU',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  bool isValidAddress() {
    return currentProvince != null &&
        currentDistrict != null &&
        currentVillage != null;
  }

  String getAddress() {
    return detailAddressCtr.text +
        ',' +
        currentVillage +
        ',' +
        currentDistrict +
        ',' +
        currentProvince;
  }

  void setAddress(String address) {
    if (address.contains(',')) {
      var str = address.split(',');
      currentProvince = str[2];
      currentDistrict = str[1];
      currentVillage = str[0];
    }
  }

  String getAddressUpdate(String value) {
    if (!value.contains(',')) {
      return value;
    }
    return value.split(',').first;
  }

  String getValue(int type) {
    switch (type) {
      case 0:
        return currentProvince;
      case 1:
        return currentDistrict;
      case 2:
        return currentVillage;

        break;
      default:
    }
    return null;
  }

  String getTitle(String content) {
    return isSend ? content + ' gửi' : content + ' nhận';
  }

  String getDistrict(String address) {
    var listAddress = address.split(',');
    return listAddress.elementAt(listAddress.length - 2).trim();
  }

  String getVillage(String address) {
    var listAddress = address.split(',');
    return listAddress.elementAt(listAddress.length - 3).trim();
  }
}
