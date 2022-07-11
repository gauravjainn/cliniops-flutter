import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// firebase to get Decive data and firebase token
class FirebaseService {

  Future<String?> getFirebaseToken() {
    final messaging = FirebaseMessaging.instance;
    return messaging.getToken();
  }

  Future<String> getDeviceId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final resp = await deviceInfoPlugin.androidInfo;
      return resp.androidId ?? 'NA';
    } else {
      final resp = await deviceInfoPlugin.iosInfo;
      return resp.identifierForVendor ?? 'NA';
    }
  }
}
