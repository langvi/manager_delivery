import 'dart:async';

import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:meta/meta.dart';

part 'detail_customer_event.dart';
part 'detail_customer_state.dart';

class DetailCustomerBloc extends BaseBloc<DetailCustomerEvent, DetailCustomerState> {
  DetailCustomerBloc() : super(DetailCustomerInitial());

  @override
  Stream<DetailCustomerState> mapEventToState(
    DetailCustomerEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
