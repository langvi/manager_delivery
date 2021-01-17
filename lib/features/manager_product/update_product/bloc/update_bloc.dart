import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:meta/meta.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends BaseBloc<UpdateEvent, UpdateState> {
  UpdateBloc() : super(UpdateInitial());

  @override
  Stream<UpdateState> mapEventToState(
    UpdateEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
