import 'dart:convert';
import 'dart:io';

import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/services/services.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:http/http.dart';

// HTTPS call repo
class HttpService {
  final String _baseUrl = AppEnvironment.getApiURL();
  static String authToken = '';

  Map<String, String> headers = {
    'content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> makeGetRequest(
    String url,
    Map<String, dynamic> payload, {
    bool isNonAuth = false,
  }) async {
    try {
      url = _baseUrl + url;
      if (!isNonAuth) {
        payload = await _feedRequestData(payload);
      }

      final uri = Uri.parse(url).replace(queryParameters: payload);

      var response = await get(uri, headers: headers);

      return await responseData(response);
    } on SocketException {
      throw SocketException(S.of(AppEnvironment.ctx).noInternet);
    } catch (e) {
      throw FetchDataException(e);
    }
  }

// t common function to make POST METHOD calls
  Future<dynamic> makePostRequest(
    String url,
    Map<String, dynamic> payload, {
    bool isNonAuth = false,
    String? baseUrl,
  }) async {
    try {
      url = (baseUrl ?? _baseUrl) + url;
      // print()
      if (!isNonAuth) {
        payload = await _feedRequestData(payload);
      }

      Logger.logMsg(this, payload);

      Logger.logMsg(this, url);
      var response = await post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(payload),
      );
      Logger.logMsg(this, response.body);
      return await responseData(response);
    } on SocketException {
      throw SocketException(S.of(AppEnvironment.ctx).noInternet);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> _feedRequestData(
    Map<String, dynamic> payload,
  ) async {
    var map = {...payload};
    final sessionId = await SecureStorage().getToken(DbKeys.sessionId);
    if (sessionId is String && sessionId.isNotEmpty) {
      map['sessionId'] = sessionId.toString();
    }
    return map;
  }

// response handle function
  Future<dynamic> responseData(Response response) async {
    var responseJson = jsonDecode(response.body);
    Logger.logMsg(this, 'Request status code: ${response.statusCode}');
    Logger.logMsg(this, 'Request response: ${jsonEncode(responseJson)}');

    dynamic status;
    dynamic message;
    if (responseJson is Map) {
      status = responseJson['Status'];
      status ??= responseJson['status'];

      Logger.logMsg(this, status);

      message = responseJson['message'];
      message ??= responseJson['Message'];
    } else {
      status = 200;
    }
    if (status == '200') {
      status = 200;
    }

    status ??= response.statusCode;
    switch (response.statusCode) {
      case 200:
      case 201:
      case 206:
        if (status != null && status == 200) {
          if (responseJson is Map) {
            authToken = responseJson['sessionId'] != null
                ? responseJson['sessionId'].toString()
                : '';
            if (authToken.isNotEmpty) {
              await SecureStorage().addPreferences(DbKeys.sessionId, authToken);
              return responseJson;
            }
          }
          return responseJson;
        }
        if (status == 1007) {
          throw UnauthorisedException(S.of(AppEnvironment.ctx).sessionExpired);
        }
        throw InvalidDataException(message.toString());
      case 400:
      case 510:
        throw BadRequestException(responseJson['error']['info']);
      case 401:
        // TODO: navigate to login page
        // AppEnvironment.navigator
        //     .pushNamedAndRemoveUntil(AuthRoutes.enterMobile, (route) => false);
        throw UnauthorisedException(S.of(AppEnvironment.ctx).sessionExpired);
      case 403:
        throw BadRequestException('S.of(AppEnvironment.ctx).verifyEmail');
      case 404:
      case 500:
      case 503:
        throw UnauthorisedException(S.of(AppEnvironment.ctx).sessionExpired);

      default:
        var message = S.of(AppEnvironment.ctx).somethingWrong;
        // if (responseJson['error']['info'] != null) {
        //   message = responseJson['error']['info'].toString();
        // } else if (responseJson['error']['message'] != null) {
        //   message = responseJson['error']['message'].toString();
        // }
        throw BadRequestException(message);
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
