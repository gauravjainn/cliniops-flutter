import 'dart:convert';

import 'package:intl/intl.dart';

///[CUSTOM Parsing for dart types {double | String | int | DateTime }]
double? parseDouble(json) {
  double? parsedData;
  if (json != null) {
    var data = json.toString();
    try {
      parsedData = double.tryParse(data);
    } catch (e) {
      parsedData = null;
    }
    return parsedData;
  }
  return null;
}

int? parseInt(json) {
  int? parsedData;
  if (json != null) {
    var data = json.toString();
    try {
      parsedData = int.tryParse(data);
    } catch (e) {
      parsedData = null;
    }
    return parsedData;
  }
  return null;
}

String? toCustomString(json) {
  if (json != null) {
    return json.toString();
  }
  return null;
}

DateTime? parseDateTime(String? json) {
  if (json != null && json.isNotEmpty) {
    DateTime? date;
    try {
      date = DateTime.tryParse(json);
    } catch (e) {
      date = parseDateFromCustomString(json, 'yyyy-MM-dd');
    }
    return date;
  }
  return null;
}

DateTime? parseDateFromCustomString(String? date,
    [String parseFormat = 'dd-MMMM-yyyy']) {
  if (date?.isEmpty ?? true) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
  try {
    var dateFormat = DateFormat(parseFormat);
    var a = dateFormat.parse(date ?? '');
    return a;
  } catch (e) {
    return null;
  }
}

String getStringFromDate(DateTime date,
    [String parseFormat = 'yyyy-mm-dd hh:mm:ss']) {
  try {
    return date.toString();
    // return date.formatDate(parseFormat);
  } catch (e) {
    return '';
  }
}

List parseList(String? data) {
  if (data?.isEmpty ?? true) {
    return [];
  }
  try {
    final list = jsonDecode(data.toString()) as List?;
    return list ?? [];
  } catch (e) {
    return [];
  }
}
