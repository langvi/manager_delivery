import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:manage_delivery/base/bloc/base_bloc.dart';
import 'package:manage_delivery/features/statistic/model/chart_repository.dart';
import 'package:manage_delivery/features/statistic/model/chart_response.dart';
import 'package:meta/meta.dart';

part 'statistic_event.dart';
part 'statistic_state.dart';

class StatisticBloc extends BaseBloc<StatisticEvent, StatisticState> {
  StatisticBloc() : super(StatisticInitial());
  final _chartRepo = ChartRepository();
  @override
  Stream<StatisticState> mapEventToState(
    StatisticEvent event,
  ) async* {
    if (event is GetInforByTime) {
      yield* _getInforByTime(event);
    }
  }

  Stream<StatisticState> _getInforByTime(GetInforByTime event) async* {
    yield Loading();
    var res = await _chartRepo.getData(event.fromDate, event.toDate);
    if (res.isSuccess) {
      yield GetInforSuccess(res.data);
    } else {
      yield Error();
    }
  }
}
