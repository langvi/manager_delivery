import 'dart:async';

import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:manage_delivery/features/manager_product/model/infor_response.dart';
import 'package:manage_delivery/features/manager_product/model/product_repository.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends BaseBloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial());
  final _productRepository = ProductRepository();
  int pageIndex = 0;
  @override
  void onError(Object error, StackTrace stacktrace) {
    if (pageIndex > 0) {
      pageIndex--;
    }
    super.onError(error, stacktrace);
  }

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is GetAllProduct) {
      yield* _getAllProduct(event);
    } else if (event is GetInforProduct) {
      yield* _getInforProduct(event);
    } else if (event is GetInforCustomer) {
      yield* _getInforCusOfProduct(event);
    } else if (event is FindProduct) {
      yield* _findProduct(event);
    }
  }

  Stream<ProductState> _getAllProduct(GetAllProduct event) async* {
    if (event.isLoadMore) {
      pageIndex++;
    } else if (event.isRefresh) {
      pageIndex = 0;
    } else {
      yield Loading();
    }
    var response = await _productRepository.getProducts(
        pageIndex: pageIndex, type: event.type);
    if (response.isSuccess) {
      yield event.isLoadMore
          ? GetMoreProductSuccess(response.data)
          : GetAllProductSuccess(response.data);
    } else {
      yield Error();
    }
  }

  Stream<ProductState> _getInforProduct(GetInforProduct event) async* {
    if (!event.isRefresh) {
      yield Loading();
    }
    var response = await _productRepository.getInforProduct();
    if (response.isSuccess) {
      yield GetInforSuccess(response.infor);
    } else {
      yield Error();
    }
  }

  Stream<ProductState> _findProduct(FindProduct event) async* {
    yield Loading();
    var res = await _productRepository.findProduct(event.keySearch);
    if (res.isSuccess) {
      yield FindSuccess(res.data);
    } else {
      yield FindError(res.message);
    }
  }

  Stream<ProductState> _getInforCusOfProduct(GetInforCustomer event) async* {
    yield Loading();
    var response =
        await _productRepository.getInforCustomerOfProduct(event.product.id);
    if (response.isSuccess) {
      yield GetInforCustomerSuccess(response.infor, event.product);
    } else {
      yield Error();
    }
  }
}
