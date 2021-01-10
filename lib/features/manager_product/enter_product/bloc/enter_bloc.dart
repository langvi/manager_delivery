import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:manage_delivery/features/manager_product/enter_product/model/enter_repository.dart';
import 'package:manage_delivery/features/manager_product/model/product_response.dart';
import 'package:meta/meta.dart';

part 'enter_event.dart';
part 'enter_state.dart';

class EnterBloc extends BaseBloc<EnterEvent, EnterState> {
  EnterBloc() : super(EnterInitial());
  final _enterRepository = EnterRepository();
  @override
  Stream<EnterState> mapEventToState(
    EnterEvent event,
  ) async* {
    if (event is EnterProduct) {
      yield* _enterProduct(event);
    }
  }

  Stream<EnterState> _enterProduct(EnterProduct event) async* {
    var res = await _enterRepository.enterProduct(event.id);
    if (res.isSuccess) {
      yield EnterSuccess(res.data);
    } else {
      yield Error(res.message);
    }
  }
}
