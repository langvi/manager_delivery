import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                automaticallyImplyLeading: false,
                title: Text(
                  'Quản lí hàng hóa',
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          _buildSearchInput(),
          const SizedBox(
            height: 10,
          ),

          // _buildGeneral(),
          _buildListProduct()
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
    return ListView.separated(
      itemCount: products.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey,
        );
      },
      itemBuilder: (context, index) {
        // return ListTile(title: Text(products[index].nameProduct));
        return _buildItemProduct(index);
      },
    );
  }

  Widget _buildItemProduct(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppConst.routeDetailProduct);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mã đơn hàng: ${products[index].id}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(products[index].createdAt),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text('Người gửi: ${products[index].sendFrom}'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Địa chỉ: ${products[index].address}'),
              Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: Text(
                    getStatus(products[index].status),
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          )
        ],
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
