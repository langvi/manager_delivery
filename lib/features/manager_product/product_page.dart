import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:manage_delivery/base/consts/colors.dart';
import 'package:manage_delivery/base/view/base_staful_widget.dart';
import 'package:manage_delivery/features/manager_product/bloc/product_bloc.dart';
import 'package:manage_delivery/features/manager_product/model/infor_response.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';
import 'package:manage_delivery/utils/convert_value.dart';
import 'package:manage_delivery/utils/dropdown_widget.dart';
import 'package:manage_delivery/utils/input_text.dart';
import 'package:manage_delivery/utils/status_product.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../base/consts/const.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState
    extends BaseStatefulWidgetState<ProductPage, ProductBloc>
    with SingleTickerProviderStateMixin {
  List<Product> products = [];
  TextEditingController searchController = TextEditingController();
  final _refreshController = RefreshController();
  final _scrollController = ScrollController();
  String currentValue = 'Tất cả';
  List<String> values = ['Tất cả', 'Đống Đa'];
  InforProduct inforProduct;
  @override
  void initBloc() {
    inforProduct = InforProduct();
    bloc = ProductBloc();
    bloc.add(GetAllProduct());
    bloc.add(GetInforProduct());
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
            _refreshController.refreshCompleted();
          } else if (state is GetMoreProductSuccess) {
            products.addAll(state.products);
            _refreshController.loadComplete();
          } else if (state is GetInforSuccess) {
            isShowLoading = false;
            inforProduct = state.inforProduct;
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
                      onPressed: () {}),
                  _popUpMenu()
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Danh sách đơn hàng',
                style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(child: _buildListProduct())
      ],
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
            _buildItem('Tất cả ', inforProduct.totalProduct,
                AppColors.gradientAll),
            SizedBox(
              width: 5,
            ),
            _buildItem('Đang lấy', inforProduct.totalGetting,
                AppColors.gradientGetProduct),
            SizedBox(
              width: 5,
            ),
            _buildItem('Đang giao', inforProduct.totalShipping,
                AppColors.gradientShipping),
            SizedBox(
              width: 5,
            ),
            _buildItem('Đã giao', inforProduct.totalShiped,
                AppColors.gradientShipped),
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

  Widget _buildListProduct() {
    return SmartRefresher(
      scrollController: _scrollController,
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onLoading: () {
        bloc.add(GetAllProduct(isLoadMore: true));
      },
      onRefresh: () {
        bloc.add(GetAllProduct(isRefresh: true));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return _buildItemProduct(index);
          },
        ),
      ),
    );
  }

  Widget _buildItemProduct(int index) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppConst.routeDetailProduct,
              arguments: products[index]);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: getGradient(products[index].statusShip,
                              products[index].isSuccess)),
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
                            // overflow: TextOverflow.ellipsis,
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
                        SizedBox(width: 5),
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

  Widget _popUpMenu() {
    return PopupMenuButton(onSelected: (value) {
      if (value == 1) {
        Navigator.pushNamed(context, AppConst.routeEnterProduct);
      } else {
        Navigator.pushNamed(context, AppConst.routeCreateProduct);
      }
    }, itemBuilder: (context) {
      var list = List<PopupMenuEntry<Object>>();
      list.add(
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(
                AntDesign.qrcode,
                color: Colors.black,
              ),
              SizedBox(
                width: 5,
              ),
              Text("Nhập hàng"),
            ],
          ),
        ),
      );
      list.add(
        PopupMenuDivider(
          height: 10,
        ),
      );
      list.add(
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(
                AntDesign.edit,
                color: Colors.blue,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Tạo đơn hàng",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      );
      return list;
    });
  }
}
