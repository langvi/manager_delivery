import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:manage_delivery/features/manager_product/address/model/create_repository.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';
import 'package:meta/meta.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends BaseBloc<UpdateEvent, UpdateState> {
  UpdateBloc() : super(UpdateInitial());

  @override
  Stream<UpdateState> mapEventToState(
    UpdateEvent event,
  ) async* {
    // if (event is UpdateProduct) {
    //   yield* _updateProduct(event);
    // }
  }

  // Stream<UpdateState> _updateProduct(UpdateProduct event) async* {
  //   yield Loading();
  //   final _createRepository = CreateRepository();
  //   var res = await _createRepository.updateProduct(event.product);
  //   if (res.isSuccess) {
  //     yield UpdateSuccess();
  //   }
  // }
}
