import 'dart:async';

import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:meta/meta.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends BaseBloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial());

  @override
  Stream<AddressState> mapEventToState(
    AddressEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
