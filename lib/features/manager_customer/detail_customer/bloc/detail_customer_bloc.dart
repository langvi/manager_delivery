import 'dart:async';

import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:manage_delivery/features/manager_customer/model/customer_repository.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';
import 'package:meta/meta.dart';

part 'detail_customer_event.dart';
part 'detail_customer_state.dart';

class DetailCustomerBloc
    extends BaseBloc<DetailCustomerEvent, DetailCustomerState> {
  DetailCustomerBloc() : super(DetailCustomerInitial());
  final _customerRepository = CustomerRepository();
  @override
  Stream<DetailCustomerState> mapEventToState(
    DetailCustomerEvent event,
  ) async* {
    if (event is GetProductByCustomer) {
      yield Loading();
      var res =
          await _customerRepository.getProductbyCustomer(event.customerId);
      if (res.isSuccess) {
        yield GetProductSuccess(
            products: res.data.products,
            totalCreate: res.data.totalCreate,
            totalGetting: res.data.totalGetting,
            totalShiped: res.data.totalShiped,
            totalShipping: res.data.totalShipping);
      } else {
        yield Error();
      }
    } else if (event is FindProduct) {
      yield* _findProduct(event);
    }
  }

  Stream<DetailCustomerState> _findProduct(FindProduct event) async* {
    yield Loading();
    final _cusRepository = CustomerRepository();
    var res = await _cusRepository.findProductByCustomer(
        event.customerId, event.productId);
    if (res.isSuccess) {
      yield FindSuccess(res.product);
    } else {
      yield Error(message: res.message);
    }
  }
}
