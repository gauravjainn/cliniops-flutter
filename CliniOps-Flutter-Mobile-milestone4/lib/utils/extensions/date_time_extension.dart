import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// format date with given date format
  String formatDate(String parseFormat) {
    return DateFormat(parseFormat).format(this);
  }

  bool isSameDate(DateTime date) {
    return date.year == year && date.month == month && date.day == day;
  }

  DateTime get onlyDate => DateTime(year, month, day);
}
