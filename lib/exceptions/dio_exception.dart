import 'dart:convert';
import 'package:dio/dio.dart';

import '../base/app_base.dart';
import '../base/app_extension.dart';
import '../config/app_enums.dart';
import '../config/app_string.dart';
import 'app_exception.dart';

class AppDioException implements Exception {
  String message = '';
  AppBase appBase = AppBase();

  @override
  String toString() => message;

  AppDioException.createDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = AppStrings.errorDiaReqCancel + ', Code: 601';
        break;

      case DioExceptionType.connectionTimeout:
        message = AppStrings.errorDiaConnectionTimeOut + ', Code: 602';
        break;

      case DioExceptionType.receiveTimeout:
        message = AppStrings.errorDiaResTimeOut + ', Code: 603';
        break;

      case DioExceptionType.sendTimeout:
        message = AppStrings.errorDiaReqTimeOut + ', Code: 604';
        break;

      case DioExceptionType.badResponse:
        message = handleResponseError(dioError.response);
        break;

      case DioExceptionType.unknown:
        appBase.showToast(AppStrings.errorDiaNoInternet,
            msgType: ToastType.error.value);
        message = AppStrings.errorDiaNoInternet + ', Code: 605';
        break;

      default:
        message = AppStrings.errorDiaWentWrong + ', Code: 606';
        break;
    }
  }

  String handleResponseError(Response? response) {
    AppErrorPrint.getStaticPrint('Response error: ' + response.toString());
    String msg = handleResponseMessage(response);
    try {
      if (response != null &&
          response.statusCode != null &&
          response.statusCode! > 0) {
        switch (response.statusCode) {
          case 400:
            return (!appBase.isFieldEmpty(msg)
                    ? msg
                    : AppStrings.errorDiaBadReq) +
                ', Code ${response.statusCode}';
          case 401:
            return (!appBase.isFieldEmpty(msg)
                    ? msg
                    : AppStrings.errorDiaUnAuth) +
                ', Code ${response.statusCode}';
          case 403:
            return (!appBase.isFieldEmpty(msg)
                    ? msg
                    : AppStrings.errorDiaServerRefuses) +
                ', Code ${response.statusCode}';
          case 404:
            return (!appBase.isFieldEmpty(msg)
                    ? msg
                    : AppStrings.errorDiaPageNotFound) +
                ', Code ${response.statusCode}';
          case 405:
            return (!appBase.isFieldEmpty(msg)
                    ? msg
                    : AppStrings.errorDiaReqNotAllowed) +
                ', Code ${response.statusCode}';
          case 500:
            return (!appBase.isFieldEmpty(msg)
                    ? msg
                    : AppStrings.errorDiaInternalServer) +
                ', Code ${response.statusCode}';
          case 502:
            return (!appBase.isFieldEmpty(msg)
                    ? msg
                    : AppStrings.errorDiaBadGateway) +
                ', Code ${response.statusCode}';
          case 503:
            return (!appBase.isFieldEmpty(msg)
                    ? msg
                    : AppStrings.errorDiaNoService) +
                ', Code ${response.statusCode}';
          case 505:
            return (!appBase.isFieldEmpty(msg)
                    ? msg
                    : AppStrings.errorDiaNoHttp) +
                ', Code ${response.statusCode}';
          default:
            return (!appBase.isFieldEmpty(msg)
                    ? msg
                    : AppStrings.errorDiaUnknownRes) +
                ', Code ${response.statusCode}';
        }
      } else {
        return msg;
      }
    } on Exception catch (_) {
      return AppStrings.errorDiaResWentWrong + 'Code: 607';
    }
  }

  String handleResponseMessage(Response? response) {
    if (response != null) {
      if (response.data != null) {
        try {
          AppErrorException appException =
              AppErrorException.fromJson(jsonDecode(response.toString()));
          if (appException.errors != null &&
              appException.errors!.details != null &&
              appException.errors!.details!.isNotEmpty &&
              !appBase.isFieldEmpty(appException.errors!.details![0].message)) {
            String msg1 =
                appBase.validString(appException.errors!.details![0].message);
            appBase.showToast(msg1);
            AppErrorPrint.getStaticPrint('Api err handle 1: ' + msg1);
            return msg1;
          } else if (!appBase.isFieldEmpty(appException.message)) {
            appBase.showToast(appBase.validString(appException.message));
            AppErrorPrint.getStaticPrint('Api err handle 2: ' +
                appBase.validString(appException.message));
            return appException.message!;
          } else if (!appBase.isFieldEmpty(appException.detail)) {
            appBase.showToast(appBase.validString(appException.detail));
            AppErrorPrint.getStaticPrint('Api err handle 3: ' +
                appBase.validString(appException.detail));
            return appException.detail!;
          } else if (!appBase.isFieldEmpty(appException.errors?.message)) {
            appBase
                .showToast(appBase.validString(appException.errors?.message));
            AppErrorPrint.getStaticPrint('Api err handle 11: ' +
                appBase.validString(appException.errors?.message));
            return appException.errors!.message!;
          } else if (!appBase.isFieldEmpty(appException.error?.message)) {
            appBase.showToast(appBase.validString(appException.error?.message));
            AppErrorPrint.getStaticPrint('Api err handle 12: ' +
                appBase.validString(appException.error?.message));
            return appException.error!.message!;
          } else {
            appBase.showToast(appBase.validString(response),
                msgType: ToastType.error.value);
            AppErrorPrint.getStaticPrint(
                'Api err handle 0: ' + appBase.validString(response));
            return AppStrings.errorDiaResWentWrong + 'Code: 608';
          }
        } catch (e) {
          String msg = appBase.validString(response);
          msg = msg.replaceAll('{', '');
          msg = msg.replaceAll('}', '');
          appBase.showToast(msg);
          AppErrorPrint.getStaticPrint(
              'Api err handle 4: ' + appBase.validString(response));
          return response.toString();
        }
      } else if (!appBase.isFieldEmpty(response.statusMessage)) {
        appBase.showToast(appBase.validString(response.statusMessage));
        AppErrorPrint.getStaticPrint(
            'Api err handle 5: ' + appBase.validString(response.statusMessage));
        return response.statusMessage!;
      } else {
        appBase.showToast(appBase.validString(response));
        AppErrorPrint.getStaticPrint(
            'Api err handle 6: ' + appBase.validString(response));
        return response.toString();
      }
    } else {
      AppErrorPrint.getStaticPrint(
          'Api err handle 7: ' + appBase.validString(response));
      appBase.showToast(appBase.validString(response),
          msgType: ToastType.error.value);
      return AppStrings.errorDiaResWentWrong + 'Code: 609';
    }
  }
}
