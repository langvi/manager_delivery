import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/view/base_staful_widget.dart';
import 'package:manage_delivery/features/manager_product/bloc/product_bloc.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';
import 'package:manage_delivery/utils/input_text.dart';

import '../../base/consts/const.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState
    extends BaseStatefulWidgetState<ProductPage, ProductBloc>
    with SingleTickerProviderStateMixin {
  List<Product> products;
  TextEditingController searchController = TextEditingController();
  // TabController _tabController;
  // int currentPage = 0;
  @override
  void initBloc() {
    bloc = ProductBloc();
    products = List<Product>.generate(6, (index) {
      return createProduct(index);
    });
    // _tabController = TabController(length: 4, vsync: this);
    // bloc.add(GetAllProduct());
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (context) => bloc,
      child: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is Loading) {
            isShowLoading = true;
          } else if (state is GetAllProductSuccess) {
            isShowLoading = false;
            products = state.products;
          } else if (state is Error) {}
        },
        builder: (context, state) {
          return baseShowLoading(
            child: Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: AppBar(
                backgroundColor: AppColors.mainColor,
                elevation: 0,
                automaticallyImplyLeading: false,
                title: Text(
                  'Quản lí hàng hóa',
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {})
                ],
              ),
              body: _buildBody(),
            ),
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
          _buildHeader(),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Danh sách đơn hàng',
              style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // _buildGeneral(),
          _buildListProduct()
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: _buildItem('Tất cả ', 120, AppColors.gradientAll)),
            SizedBox(
              width: 5,
            ),
            Expanded(
                child:
                    _buildItem('Đang lấy', 11, AppColors.gradientGetProduct)),
            SizedBox(
              width: 5,
            ),
            Expanded(
                child:
                    _buildItem('Đang giao', 100, AppColors.gradientShipping)),
            SizedBox(
              width: 5,
            ),
            Expanded(
                child: _buildItem('Đã giao', 9, AppColors.gradientShipped)),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String title, int value, List<Color> colors) {
    return Container(
      padding: EdgeInsets.all(10),
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
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(
            height: 10,
          ),
          Text('$value')
        ],
      ),
    );
  }

  Widget _buildGeneral() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildItemCard('Tạo đơn hàng', Icons.add, onClick: () {
          Navigator.pushNamed(context, AppConst.routeCreateProduct);
        }),
        _buildItemCard('Đang giao', Icons.send, onClick: () {}),
        _buildItemCard('Đã giao', Icons.home, onClick: () {}),
      ],
    );
  }

  Widget _buildItemCard(String title, IconData icon, {Function onClick}) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        color: AppColors.mainColor,
        child: Container(
          width: 100,
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                icon,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchInput() {
    return Row(
      children: [
        Expanded(
          child: BuildTextInput(
            hintText: 'Tìm kiếm',
            controller: searchController,
            filledColor: Colors.grey[300],
            iconLeading: Icons.search,
            iconNextTextInputAction: TextInputAction.search,
            submitFunc: () {},
          ),
        ),
        IconButton(
            icon: Icon(MaterialCommunityIcons.filter_variant), onPressed: () {})
      ],
    );
  }

  Product createProduct(int status) {
    return Product(
      address: '58 Le Ha Nang - Dong Da - Ha Noi',
      sendFrom: 'Alibaba',
      id: 'u3j3juwms',
      createdAt: '20/11/1111',
      status: status,
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

  String getStatus(int status) {
    String strStatus = '';
    switch (status) {
      case 0:
        strStatus = 'Đang lấy';
        break;
      case 1:
        strStatus = 'Đã lấy';
        break;
      case 2:
        strStatus = 'Đã nhập kho';
        break;
      case 3:
        strStatus = 'Đang giao';
        break;
      case 4:
        strStatus = 'Đã giao';
        break;
      default:
        strStatus = 'Chua co';
    }
    return strStatus;
  }
}
