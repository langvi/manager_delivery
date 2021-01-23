part of 'statistic_bloc.dart';

@immutable
abstract class StatisticEvent {}

class GetInforByTime extends StatisticEvent {
  final DateTime fromDate;
  final DateTime toDate;

  GetInforByTime({this.fromDate, this.toDate});
}
