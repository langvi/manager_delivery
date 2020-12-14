import 'dart:async';

import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:manage_delivery/features/manager_product/model/product_repository.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends BaseBloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial());
  final _productRepository = ProductRepository();
  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is GetAllProduct) {
      yield* _getAllProduct();
    }
  }

  Stream<ProductState> _getAllProduct() async* {
    yield Loading();
    var response = await _productRepository.getAllProduct();
    if (response.isSuccess) {
      yield GetAllProductSuccess(response.data);
    } else {
      yield Error();
    }
  }
}
