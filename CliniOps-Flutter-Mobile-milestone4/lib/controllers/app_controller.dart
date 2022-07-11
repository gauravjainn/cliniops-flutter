import 'dart:io';

import 'package:clini_app/data/data.dart';
import 'package:flutter/material.dart';
// Language Notifier
class AppNotifier with ChangeNotifier {
  Locale deviceLanguage =
      appLocale.map.containsKey(Locale(Platform.localeName.substring(0, 2)))
          ? Locale(Platform.localeName.substring(0, 2))
          : appLocale.map.keys.first;
  

  void changeDeviceLanguage(Locale locale) {
    deviceLanguage =
        appLocale.map.containsKey(locale) ? locale : appLocale.map.keys.first;
    notifyListeners();
  }
    
}
