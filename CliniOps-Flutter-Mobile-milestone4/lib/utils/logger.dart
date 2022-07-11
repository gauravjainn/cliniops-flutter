import 'package:clini_app/data/data.dart';
import 'package:flutter/foundation.dart';

import 'app_environment.dart';

class Logger {
  static void logMsg(dynamic obj, dynamic msg) {
    if (AppEnvironment.env == ENV.PROD && kReleaseMode) {
      return;
    }

    var className = obj.runtimeType.toString();
    className = className == 'String' ? obj as String : className;
    debugPrint('$className msg : $msg', wrapWidth: 2048);
  }

  static void logError(dynamic obj, dynamic msg,
      {StackTrace? stackTrace}) async {
    var str = 'Error : ${msg?.toString()}';
    logMsg(obj, str);
  }
}
