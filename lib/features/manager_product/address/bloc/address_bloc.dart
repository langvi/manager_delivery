import 'dart:async';

import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:manage_delivery/features/manager_product/address/model/create_repository.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';
import 'package:meta/meta.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends BaseBloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial());
  final _createRepository = CreateRepository();
  @override
  Stream<AddressState> mapEventToState(
    AddressEvent event,
  ) async* {
    if (event is CreateProduct) {
      yield* _createProduct(event);
    }
  }

  Stream<AddressState> _createProduct(CreateProduct event) async* {
    yield Loading();
    var res = await _createRepository.createProduct(event.product);
    if (res.isSuccess) {
      yield CreateProductSuccess();
    } else {
      yield Error();
    }
  }
}
