import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:manage_delivery/base/view/base_staful_widget.dart';
import 'package:manage_delivery/features/manager_product/bloc/product_bloc.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';
import 'package:manage_delivery/utils/input_text.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState
    extends BaseStatefulWidgetState<ProductPage, ProductBloc> {
  List<Product> products = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initBloc() {
    bloc = ProductBloc();
    bloc.add(GetAllProduct());
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
                automaticallyImplyLeading: false,
                title: Text('Quản lí hàng hóa'),
                actions: [
                  IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          _buildGeneral(),
          _buildSearchInput(),
          Expanded(child: _buildListProduct())
        ],
      ),
    );
  }

  Widget _buildGeneral() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Card(
          color: Colors.orange,
          child: Container(
            width: 100,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Đang lấy'), Icon(Icons.photo_rounded)],
            ),
          ),
        ),
        Card(
          color: Colors.orange,
          child: Container(
            width: 100,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Đang giao'), Icon(Icons.send)],
            ),
          ),
        ),
        Card(
          color: Colors.orange,
          child: Container(
            width: 100,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Đã giao'), Icon(Icons.home)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchInput() {
    return BuildTextInput(
      hintText: 'Tìm kiếm',
      controller: searchController,
      filledColor: Colors.grey[300],
      iconLeading: Icons.search,
      iconNextTextInputAction: TextInputAction.search,
      submitFunc: () {},
    );
  }

  Widget _buildListProduct() {
    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey,
          indent: 10,
          endIndent: 10,
        );
      },
      itemBuilder: (context, index) {
        return ListTile(title: Text(products[index].nameProduct));
      },
    );
  }
}
