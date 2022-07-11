import 'dart:io';
import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/utils/utils.dart';

class HttpException implements Exception {
  final Object? message;

  HttpException([this.message]);

  @override
  String toString() => '$message';
}

class FetchDataException extends HttpException {
  FetchDataException([message]) : super(message);
}

class BadRequestException extends HttpException {
  BadRequestException([message]) : super(message);
}

class UnauthorisedException extends HttpException {
  UnauthorisedException([message]) : super(message);
}

class InvalidDataException extends HttpException {
  InvalidDataException([String? message]) : super(message);
}

class LocalConnectionException extends HttpException {
  LocalConnectionException([String? message])
      : super(message = 'Cannot find internet connection');
}

class ErrorHandler {
  static Responser<T> error<T>(
    e, {
    StackTrace? stackTrace,
    String? socketError,
    String? noMethod,
    String? typeError,
  }) {
    Logger.logMsg(
      e,
      e.toString() + '\n=============\n' + stackTrace.toString(),
    );
    switch (e.runtimeType) {
      case SocketException:
        return Responser<T>(
          message: socketError ?? S.of(AppEnvironment.ctx).noInternet,
          isSuccess: false,
        );
      case NoSuchMethodError:
        return Responser<T>(
          message: noMethod ?? S.of(AppEnvironment.ctx).serverError,
          isSuccess: false,
        );
      case TypeError:
        return Responser<T>(
          message: typeError ?? S.of(AppEnvironment.ctx).somethingWrong,
          isSuccess: false,
        );
      default:
        return Responser<T>(message: e.toString(), isSuccess: false);
    }
  }
}
