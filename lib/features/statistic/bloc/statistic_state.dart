part of 'statistic_bloc.dart';

@immutable
abstract class StatisticState {}

class StatisticInitial extends StatisticState {}

class Loading extends StatisticState {}
class Error extends StatisticState {}

class GetInforSuccess extends StatisticState {
  final DataChart data;

  GetInforSuccess(this.data);
}
