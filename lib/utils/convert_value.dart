import 'package:intl/intl.dart';

const String PATTERN_1 = "dd/MM/yyyy";
String convertMoney(int value) {
  final currencyFormatter =
      NumberFormat.currency(locale: 'vi', decimalDigits: 0, symbol: 'VNĐ');
  return currencyFormatter.format(value);
}

String convertDateTimeToString(DateTime date) {
  final formatter = DateFormat('HH:mm dd/MM/yyyy');
  return formatter.format(date);
}

String convertDateTimeToHour(DateTime date) {
  final formatter = DateFormat('HH:mm');
  return formatter.format(date);
}

String convertDateTimeToDay(DateTime date) {
  final formatter = DateFormat(PATTERN_1);
  return formatter.format(date);
}

DateTime convertEpochToDateTime(dynamic value) {
  return DateTime.fromMillisecondsSinceEpoch(value.toInt());
}

DateTime convertStringtoDateTime(String value) {
  return DateTime.parse(value);
}

List<String> getDateFromDropDown(String date) {
  List<String> listDate = [];
  if (date == 'Hôm nay') {
    listDate.add(DateFormat(PATTERN_1).format(DateTime.now()));
  } else if (date == 'Tuần này') {
    listDate.add(_getFirstDay(Time.thisWeek));
    listDate.add(_getLastDay(Time.thisWeek));
  } else if (date == 'Tháng này') {
    listDate.add(_getFirstDay(Time.thisMonth));
    listDate.add(_getLastDay(Time.thisMonth));
  }
  return listDate;
}

String _getFirstDay(Time time) {
  int dayOfWeek = 1; // dùng để lấy ngày đầu tiên trong tuần hiện tại
  DateTime date = DateTime.now();
  if (time == Time.lastWeek) {
    dayOfWeek = -6; // dùng để lấy ngày đầu tiên trong tuần trước đó
  }
  // lấy ngày đầu tiên trong tháng
  if (time == Time.thisMonth || time == Time.lastMonth) {
    var firstDayOfMonth;
    time == Time.lastMonth
        ? firstDayOfMonth = DateTime(
            date.year, date.month - 1, 1) // lấy ngày đầu tiên tháng trước đó
        : firstDayOfMonth = DateTime(
            date.year, date.month, 1); // lấy ngày đầu tiên tháng hiện tại
    return DateFormat(PATTERN_1).format(firstDayOfMonth);
  }
  var monday = date.subtract(Duration(days: date.weekday - dayOfWeek));
  return DateFormat(PATTERN_1).format(monday);
}

String _getLastDay(Time time) {
  DateTime date = DateTime.now();
  int dayOfWeek = 7; // dùng để lấy ngày cuối cùng trong tuần hiện tại
  if (time == Time.lastWeek) {
    dayOfWeek = 0; // dùng để lấy ngày cuối cùng trong tuần trước
  }
  if (time == Time.thisMonth || time == Time.lastMonth) {
    var lastDayOfMonth;
    // lấy ngày cuối cùng tháng hiện tại
    if (time == Time.thisMonth) {
      var beginningNextMonth = (date.month < 12)
          ? DateTime(date.year, date.month + 1, 1)
          : DateTime(date.year + 1, 1, 1);
      int lastDay = beginningNextMonth.subtract(Duration(days: 1)).day;
      lastDayOfMonth = DateTime(date.year, date.month, lastDay);
    } else {
      // lấy ngày cuối cùng tháng trước đó
      var beginningNextMonth = (date.month < 12)
          ? DateTime(date.year, date.month, 1)
          : DateTime(date.year + 1, 0, 1);
      int lastDay = beginningNextMonth.subtract(Duration(days: 1)).day;
      lastDayOfMonth = DateTime(date.year, date.month - 1, lastDay);
    }

    return DateFormat(PATTERN_1).format(lastDayOfMonth);
  }
  var sunday = date.subtract(Duration(days: date.weekday - dayOfWeek));
  return DateFormat(PATTERN_1).format(sunday);
}

enum Time { thisWeek, lastWeek, thisMonth, lastMonth }
