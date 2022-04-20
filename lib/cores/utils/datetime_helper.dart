import 'package:intl/intl.dart';

class DateTimeHelper {
  static String formatDate(
    DateTime date, {
    String format = 'dd MMM, yyyy hh:mm a',
  }) {
    return DateFormat(format).format(date);
  }
}
