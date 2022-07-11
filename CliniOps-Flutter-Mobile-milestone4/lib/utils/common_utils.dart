import 'package:clini_app/data/data.dart';
import 'package:clini_app/ui/page_not_found/page_not_found.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonUtils {
  CommonUtils._();

  static bool hasInvalidArgs<T>(Object args) {
    return (args is! T);
  }

  static Widget misTypedArgsRoute<T>(Object args) {
    return PageNotFound();
  }

  static void logEvent(
    String name, {
    Map<String, dynamic>? data,
  }) {
    var isProd = AppEnvironment.env == ENV.PROD && kReleaseMode;
    if (!isProd) {
      return;
    }

    data ??= {};

    // log event to firebase
    try {
      _logFirebaseEvent(name, data);
    } catch (e) {
      Logger.logError('Common Utils', e);
    }
  }

  static void _logFirebaseEvent(String name, Map<String, dynamic>? data) {
    AppEnvironment.analytics.logEvent(name: name, parameters: data);
  }
  static void launchURL(String url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}
}
