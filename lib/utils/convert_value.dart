import 'package:intl/intl.dart';

String convertMoney(double value) {
  final currencyFormatter =
      NumberFormat.currency(locale: 'vi', decimalDigits: 0, symbol: 'VNĐ');
  return currencyFormatter.format(value);
}

String convertDateTimeToString(DateTime date) {
  final formatter = DateFormat('HH:mm dd/MM/yyyy');
  return formatter.format(date);
}
