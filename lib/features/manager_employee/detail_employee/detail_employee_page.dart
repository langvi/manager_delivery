import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  @override
  void initBloc() {
    bloc = DetailEmployeeBloc();
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
              // backgroundColor: Colors.white,
              leading: BackButton(
                onPressed: () => Navigator.pop(context),
              ),
              title: Text('Thông tin nhân viên'),
              actions: [
                IconButton(icon: Icon(Icons.more_vert), onPressed: null)
              ],
            ),
            body: _buildBody(),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildAvatar(), _buildInfor()],
    );
  }

  Widget _buildAvatar() {
    return Container(
      color: Colors.grey,
      child: Image.asset(
        'assets/images/no_avatar.png',
        fit: BoxFit.fill,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.3,
      ),
    );
  }

  Widget _buildInfor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Ha Van SH',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
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
          child: RichText(
            text: TextSpan(
                text: 'Số điện thoại: ',
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text: '0214578963',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ]),
          ),
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
              onTap: () {},
              child: Chip(
                backgroundColor: Colors.black54,
                label: Text(
                  'Chi tiết',
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline),
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
}
