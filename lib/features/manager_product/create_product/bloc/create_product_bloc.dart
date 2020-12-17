import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../base/bloc/base_bloc.dart';

part 'create_product_event.dart';
part 'create_product_state.dart';

class CreateProductBloc extends BaseBloc<CreateProductEvent, CreateProductState> {
  CreateProductBloc() : super(CreateProductInitial());

  @override
  Stream<CreateProductState> mapEventToState(
    CreateProductEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
