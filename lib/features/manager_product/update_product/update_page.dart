import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';
import 'package:manage_delivery/features/manager_product/update_product/bloc/update_bloc.dart';

import '../../../base/view/base_staful_widget.dart';
import '../../../utils/input_text.dart';

class UpdatePage extends StatefulWidget {
  UpdatePage({Key key}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends BaseStatefulWidgetState<UpdatePage, UpdateBloc> {
  TextEditingController nameController;
  TextEditingController costController;
  TextEditingController cODController;
  TextEditingController noteController;
  final _nameFocus = FocusNode();
  final _costFocus = FocusNode();
  final _cODFocus = FocusNode();
  final _noteFocus = FocusNode();
  Product product;
  final _formKey = GlobalKey<FormState>();
  @override
  void initBloc() {
    bloc = UpdateBloc();
  }

  @override
  void didChangeDependencies() {
    if (product == null) {
      product = ModalRoute.of(context).settings.arguments;
      nameController = TextEditingController(text: product.nameProduct);
      costController = MoneyMaskedTextController( 
          initialValue: product.costShip.toDouble(),
          precision: 0,
          decimalSeparator: '');
      cODController = MoneyMaskedTextController(
          initialValue: product.costProduct.toDouble(),
          precision: 0,
          decimalSeparator: '');
      noteController = TextEditingController(text: product.note);
    }

    super.didChangeDependencies();
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return BlocProvider<UpdateBloc>(
      create: (context) => bloc,
      child: BlocConsumer<UpdateBloc, UpdateState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.mainColor,
              elevation: 0,
              leading: BackButton(
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                'Tạo đơn hàng',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [Expanded(child: _buildBody()), _buildButton()],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BuildTextInput(
                hintText: 'Nhập tên hàng hóa',
                controller: nameController,
                currentNode: _nameFocus,
                nextNode: _costFocus,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Tên hàng hóa không được để trống';
                  }
                  return null;
                },
                isBorder: true,
                filledColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BuildTextInput(
                hintText: 'Nhập số tiền cần thu',
                currentNode: _costFocus,
                nextNode: _cODFocus,
                controller: costController,
                isShowSuffixText: true,
                isShowLabel: true,
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Giá trị hàng hóa không được để trống';
                  }
                  return null;
                },
                isBorder: true,
                filledColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BuildTextInput(
                hintText: 'Nhập giá vận chuyển',
                controller: cODController,
                textInputType: TextInputType.number,
                isShowLabel: true,
                currentNode: _cODFocus,
                nextNode: _noteFocus,
                isShowSuffixText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Giá vận chuyển không được để trống';
                  }
                  return null;
                },
                isBorder: true,
                filledColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: noteController,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                style: TextStyle(fontSize: 19),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.only(
                        left: 12, right: 12, top: 6, bottom: 40),
                    hintText: 'Ghi chú',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
              ),
            ),
          ],
        ),
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
              product.nameProduct = nameController.text;
              product.costProduct = parsePrice(costController.text.trim());
              product.costShip = parsePrice(cODController.text.trim());
              product.note = noteController.text;
              Navigator.pushNamed(context, AppConst.routeUpdateAddress,
                  arguments: product);
            }
          },
          child: Text(
            'TIẾP TỤC',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  int parsePrice(String price) {
    String number = '';
    if (price.split('.').length != 0) {
      price.split('.').forEach((element) {
        number += element;
      });
    } else {
      number = price;
    }
    return int.parse(number);
  }
}
