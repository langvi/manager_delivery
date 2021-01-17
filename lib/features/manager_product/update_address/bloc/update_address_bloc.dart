import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:manage_delivery/features/manager_product/address/model/create_repository.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';
import 'package:meta/meta.dart';

part 'update_address_event.dart';
part 'update_address_state.dart';

class UpdateAddressBloc
    extends BaseBloc<UpdateAddressEvent, UpdateAddressState> {
  UpdateAddressBloc() : super(UpdateAddressInitial());
  final _repository = CreateRepository();

  @override
  Stream<UpdateAddressState> mapEventToState(
    UpdateAddressEvent event,
  ) async* {
    if (event is UpdateProduct) {
      yield Loading();
      var res = await _repository.updateProduct(event.product);
      if (res.isSuccess) {
        yield Success();
      } else {
        yield Error();
      }
    }
  }
}
