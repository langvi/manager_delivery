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
      yield* _getCustomer(event);
    } else if (event is FindCustomer) {
      yield* _findCustomer(event);
    }
  }

  Stream<CustomerState> _getCustomer(GetAllCustomer event) async* {
    if (event.isLoadMore) {
      pageIndex++;
    } else if (event.isRefresh) {
      pageIndex = 0;
    } else {
      yield Loading();
    }
    var res = await _customerRepo.getCustomers(pageIndex);
    if (res.isSuccess) {
      yield GetCustomerSuccess(res.data.customer, res.data.totalCustomer,
          isLoadMore: event.isLoadMore);
    } else {
      yield Error('Lỗi');
    }
  }

  Stream<CustomerState> _findCustomer(FindCustomer event) async* {
    yield Loading();
    var res = await _customerRepo.findCustomer(event.keySearch);
    if (res.isSuccess) {
      yield GetCustomerSuccess(res.data.customer, res.data.totalCustomer);
    } else {
      yield Error('Lỗi');
    }
  }
}
