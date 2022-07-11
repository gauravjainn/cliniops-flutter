import 'dart:async';
import 'dart:io';

import 'package:clini_app/clini_app.dart';
import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/intl/messages_es.dart';
import 'package:clini_app/services/services.dart';
import 'package:clini_app/ui/chat/call_widget.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['fonts'], license);
  });
  await Hive.initFlutter();
  await _registerHiveBoxes();
  HttpOverrides.global = MyHttpOverrides();
  configCommandLineArgs();
  // FirebaseCrashlytics configuration
  await FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(kReleaseMode);

  // await ConnectCubeService().initialize();

  // CubeSettings.instance.isDebugEnabled = kDebugMode;

// Elsewhere in your code
// FirebaseCrashlytics.instance.crash();

  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  // The following lines are the same as previously explained in "Handling uncaught errors"
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runZonedGuarded<Future<void>>(() async {
    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(const CliniApp());
  }, FirebaseCrashlytics.instance.recordError);
}

void configCommandLineArgs() {
  var cmdEnv = const String.fromEnvironment(
    EnvironmentVars.ENV,
    defaultValue: kReleaseMode ? 'PROD' : 'DEV',
  );
  AppEnvironment.env = env.map[cmdEnv] ?? (kReleaseMode ? ENV.PROD : ENV.DEV);
  // FirebaseMessaging.onBackgroundMessage((message) async {
  //   print(message.data);
  // });
}

Future<void> _registerHiveBoxes() async {
  try {
    DbEnvironment.generalBox =
        await DbService().openBox(DbEnvironment.GENERAL_BOX);
  } catch (e) {
    Logger.logError('main.dart', e);
  }
}
