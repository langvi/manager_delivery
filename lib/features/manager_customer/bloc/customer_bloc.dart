import 'dart:async';

import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:manage_delivery/features/manager_customer/model/customer_repository.dart';
import 'package:manage_delivery/features/manager_customer/model/customer_response.dart';
import 'package:meta/meta.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends BaseBloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(CustomerInitial());
  int pageIndex = 0;
  final _customerRepo = CustomerRepository();
  @override
  void onError(Object error, StackTrace stackTrace) {
    if (pageIndex > 0) {
      pageIndex--;
    }
    super.onError(error, stackTrace);
  }

  @override
  Stream<CustomerState> mapEventToState(
    CustomerEvent event,
  ) async* {
    if (event is GetAllCustomer) {
      yield* _getCustomer();
    }
  }

  Stream<CustomerState> _getCustomer() async* {
    yield Loading();
    var res = await _customerRepo.getCustomers();
    if (res.isSuccess) {
      yield GetCustomerSuccess(res.data.customer, res.data.totalCustomer);
    } else {
      yield Error('Lỗi');
    }
  }
}
