import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/consts/const.dart';
import 'package:manage_delivery/features/manager_product/create_product/bloc/create_product_bloc.dart';

import '../../../base/view/base_staful_widget.dart';
import '../../../utils/input_text.dart';

class CreateProductPage extends StatefulWidget {
  CreateProductPage({Key key}) : super(key: key);

  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState
    extends BaseStatefulWidgetState<CreateProductPage, CreateProductBloc> {
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController cODController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final _nameFocus = FocusNode();
  final _costFocus = FocusNode();
  final _cODFocus = FocusNode();
  final _noteFocus = FocusNode();
  int countValue = 1;
  final _formKey = GlobalKey<FormState>();
  @override
  void initBloc() {
    bloc = CreateProductBloc();
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return BlocProvider<CreateProductBloc>(
      create: (context) => bloc,
      child: BlocConsumer<CreateProductBloc, CreateProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => Navigator.pop(context),
              ),
              title: Text('Tạo đơn hàng'),
              centerTitle: true,
            ),
            body: Stack(children: [
              _buildBody(),
              Positioned(left: 10, right: 10, bottom: 5, child: _buildButton())
            ]),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BuildTextInput(
            hintText: 'Nhập tên hàng hóa',
            controller: nameController,
            currentNode: _nameFocus,
            nextNode: _costFocus,
            isBorder: true,
            filledColor: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BuildTextInput(
            hintText: 'Nhập số tiền cần thu',
            obscureText: true,
            currentNode: _costFocus,
            nextNode: _cODFocus,
            controller: costController,
            isBorder: true,
            filledColor: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BuildTextInput(
            hintText: 'Nhập giá vận chuyển',
            controller: cODController,
            currentNode: _cODFocus,
            nextNode: _noteFocus,
            isBorder: true,
            filledColor: Colors.white,
          ),
        ),
        _buildCount(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: noteController,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            style: TextStyle(fontSize: 19),
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.only(
                    left: 12, right: 12, top: 6, bottom: 40),
                hintText: 'Ghi chú',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
          ),
        )
      ],
    );
  }

  Widget _buildButton() {
    return RaisedButton(
      color: AppColors.mainColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {
        Navigator.pushNamed(context, AppConst.routeCreateAddress);
      },
      child: Text(
        'TIẾP TỤC',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildCount() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Text('Chọn số lượng'),
            const Spacer(),
            IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                onPressed: () {
                  countProduct(false);
                }),
            const SizedBox(
              width: 20,
            ),
            Text(countValue.toString()),
            const SizedBox(
              width: 20,
            ),
            IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: () {
                  countProduct(true);
                }),
          ],
        ),
      ),
    );
  }

  void countProduct(bool isIncrement) {
    if (countValue > 0) {
      setState(() {
        countValue = isIncrement ? countValue += 1 : countValue -= 1;
      });
    } else {
      if (isIncrement) {
        setState(() {
          countValue++;
        });
      }
    }
  }
}
