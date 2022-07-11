import 'package:clini_app/data/data.dart';
// import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppEnvironment {
  AppEnvironment._();

  static bool isUserLoggedIn = false;
  static ENV env = kReleaseMode ? ENV.PROD : ENV.DEV;
  static String apiUrl = '';
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static UserData? user;
  // static CubeUser? cubeUser;

  static final deepLinkPath = ValueNotifier<String>('');
  static final rootNavigationKey = GlobalKey<NavigatorState>();
  static final routeObserver = RouteObserver<ModalRoute>();
  static final ValueNotifier<Object?> deepLinkArgs = ValueNotifier(null);
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const channel = AndroidNotificationChannel(
    'default_channel', // id
    'Default Notifications', // title
    description:
        'This channel is used for default notifications.', // description
    importance: Importance.high,
  );

  static late PackageInfo packageInfo;

  static BuildContext get ctx => rootNavigationKey.currentContext!;

  static NavigatorState get navigator => rootNavigationKey.currentState!;

  static String getApiURL() {
    switch (env) {
      case ENV.DEV:
        apiUrl = 'https://sandbox.cliniops.com';
        break;
      case ENV.STAG:
        apiUrl = 'https://sandbox.cliniops.com';
        break;
      case ENV.PROD:
        apiUrl = 'https://sandbox.cliniops.com';
        break;
      case ENV.CUSTOM:
        apiUrl = 'https://sandbox.cliniops.com';
        break;
    }
    return apiUrl;
  }
}
