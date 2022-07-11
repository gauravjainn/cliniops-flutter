import 'dart:io';

import 'package:clini_app/data/data.dart';
import 'package:clini_app/services/services.dart';
import 'package:clini_app/utils/utils.dart';

// Repository for authentication
class AuthRepo {
  final _httpService = HttpService();

  static const _baseAuthUrl = '/subject/eprowebservice';

  static String _sessionId = '';

  String get sessionId => _sessionId;

  Future<Responser<UserData>> login({
    required String email,
    required String password,
  }) async {
    try {
      var deviceId = await FirebaseService().getDeviceId();
      var firebaseToken = await FirebaseService().getFirebaseToken();

      final payload = {
        'username': email,
        'password': password,
        'platform': Platform.operatingSystem,
        'deviceToken': firebaseToken,
        'serialNo': deviceId
      };
      final resp = await _httpService.makePostRequest(
        _baseAuthUrl + '/login',
        payload,
        isNonAuth: true,
      );
      _sessionId = resp['sessionId'].toString();
      final res = UserData.fromJson(resp as Map);

      return Responser<UserData>(
        message: 'Login success',
        isSuccess: true,
        data: res,
      );
    } catch (e) {
      return ErrorHandler.error<UserData>(e);
    }
  }

  Future<Responser> changePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    final payload = {
      'userId': userId,
      'oldpassword': oldPassword,
      'newpassword': newPassword,
    };

    try {
      final resp = await _httpService.makePostRequest(
        _baseAuthUrl + '/changepassword',
        payload,
      );
      return Responser(
        message: resp['message'].toString(),
        isSuccess: true,
      );
    } catch (e) {
      return ErrorHandler.error(e);
    }
  }

  Future<Responser> forgotPassword({
    required String emailId,
  }) async {
    final payload = {'emailID': emailId};

    try {
      final resp = await _httpService.makePostRequest(
        _baseAuthUrl + '/forgotpassword',
        payload,
      );
      return Responser(
        message: resp['message'].toString(),
        isSuccess: true,
      );
    } catch (e) {
      return ErrorHandler.error(e);
    }
  }

  Future<Responser<String>> getLogo({
    required String username,
  }) async {
    final payload = {'username': username};

    try {
      final resp = await _httpService.makePostRequest(
        'login/webservice/getcompany',
        payload,
        baseUrl: CLINI_OPS_URL,
      );
      var res = resp as List;
      if (res.isNotEmpty) {

        return Responser(
          data: res.first['company_logo'].toString(),
          message: res.first['company_logo'].toString(),
          isSuccess: true,
        );
      }
      return Responser(message: 'Failed to get logo', isSuccess: false);
    } catch (e) {
      return ErrorHandler.error(e);
    }
  }
}
