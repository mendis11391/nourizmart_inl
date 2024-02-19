import 'dart:io';

import '../../api_export.dart';

class AppDioException implements Exception {
  AppDioException.createDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        throw AppErrorException(
          success: false,
          message: 'Request cancellation',
        );

      case DioExceptionType.connectionTimeout:
        throw AppErrorException(
          success: false,
          message: 'Connection timed out',
        );

      case DioExceptionType.receiveTimeout:
        throw AppErrorException(
          success: false,
          message: 'Response timeout',
        );

      case DioExceptionType.sendTimeout:
        throw AppErrorException(
          success: false,
          message: 'Request timed out',
        );

      case DioExceptionType.badResponse:
        throw handleNewResponseError(dioError.response);

      case DioExceptionType.unknown:
        throw AppErrorException(
          success: false,
          message: 'No Internet Connection!!!',
        );

      default:
        throw AppErrorException(
          success: false,
          message: 'Something went wrong',
        );
    }
  }

  AppErrorException handleNewResponseError(Response? response) {
    String msg = handleResponseMessage(response);
    try {
      if (response != null &&
          response.statusCode != null &&
          response.statusCode! > 0) {
        switch (response.statusCode) {
          case HttpStatus.badRequest: // 400
            msg = !isFieldEmpty(msg) ? msg : 'Bad request error';
            break;
          case HttpStatus.unauthorized: // 401
            msg = !isFieldEmpty(msg) ? msg : 'Unauthorized';
            break;
          case HttpStatus.forbidden: // 403
            msg = !isFieldEmpty(msg) ? msg : 'The server refuses to execute';
            break;
          case HttpStatus.notFound: // 404
            msg = !isFieldEmpty(msg) ? msg : 'Page not found';
            break;
          case HttpStatus.methodNotAllowed: // 405
            msg = !isFieldEmpty(msg) ? msg : 'Request method not allowed';
            break;
          case HttpStatus.internalServerError: // 500
            msg = !isFieldEmpty(msg) ? msg : 'Internal server error';
            break;
          case HttpStatus.badGateway: // 502
            msg = !isFieldEmpty(msg) ? msg : 'Bad gateway';
            break;
          case HttpStatus.serviceUnavailable: // 503
            msg = !isFieldEmpty(msg) ? msg : 'Service unavailable';
            break;
          case HttpStatus.httpVersionNotSupported: // 505
            msg = !isFieldEmpty(msg)
                ? msg
                : 'HTTP protocol request is not supported';
            break;
          default:
            msg = !isFieldEmpty(msg) ? msg : 'Unknown response mistake';
        }
        return AppErrorException(
          success: false,
          message: msg,
        );
      } else {
        throw AppErrorException(
          success: false,
          message: msg,
        );
      }
    } on Exception catch (_) {
      throw AppErrorException(
        success: false,
        message: 'Oops response went wrong',
      );
    }
  }

  String handleResponseMessage(Response? response) {
    if (response != null) {
      if (response.data != null) {
        final responseData = response.data;
        try {
          AppErrorException appException =
              AppErrorException.fromJson(jsonDecode(responseData));
          if (!isFieldEmpty(appException.message)) {
            return appException.message!;
          }
        } on Exception catch (_) {
          return validString(
              response.statusMessage ?? 'Oops response went wrong');
        }
      }
    }
    return 'Oops response went wrong';
  }
}
