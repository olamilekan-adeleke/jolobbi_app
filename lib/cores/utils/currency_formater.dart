import 'package:intl/intl.dart';

String currencyFormatter(int amount, {bool addDecimal = true}) {
  if (addDecimal) {
    final NumberFormat formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(amount);
  } else {
    final NumberFormat formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(amount);
  }
}
