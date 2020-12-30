import 'dart:async';

import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:meta/meta.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends BaseBloc<DetailProductEvent, DetailProductState> {
  DetailProductBloc() : super(DetailProductInitial());

  @override
  Stream<DetailProductState> mapEventToState(
    DetailProductEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
