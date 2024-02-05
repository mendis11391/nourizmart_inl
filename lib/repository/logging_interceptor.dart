import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nourish_mart/base/app_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/app_toast.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int _maxCharactersPerLine = 200;
  SharedPreferences? sharedPreferences;
  AppBase appBase = AppBase();

  LoggingInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('Request: ${options.method} ${options.uri}');

    if (options.data != null) {
      try {
        final decodedData = jsonDecode('${options.data.toString()}');
        final formattedData = jsonEncode(decodedData);
        log('Request data: $formattedData');
      } catch (e) {
        log('Request data: Error decoding or formatting JSON');
        log('Original Request data: ${options.data}');
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('Response: ${response.statusCode} ${response.requestOptions.uri}');
    if (response.data != null) {
      log('Response data: ${jsonEncode(response.data)}');
    }
    String responseAsString = response.data.toString();
    if (responseAsString.length > _maxCharactersPerLine) {
      int iterations =
          (responseAsString.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
      }
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (err.error is SocketException) {
      AppToast.show("No Internet Found ", Colors.red, Colors.white);
      super.onError(err, handler);
    }
    if (err.response != null) {
      int responseCode = err.response!.statusCode!;

      var decodedData = jsonDecode(err.response.toString());
      // if (responseCode == 401 &&
      //     decodedData["message"] != "Invalid Credentials") {
      //   Repository repository = Repository();
      //   ProfileResponseModel? profileResponseModel =
      //       await repository.getNewAccessToken();
      //   sharedPreferences!.clear();

      //   if (profileResponseModel?.data != null) {
      //     sharedPreferences!.setString(
      //         "access_token", profileResponseModel!.data!.token!.access!);
      //     sharedPreferences!.setString(
      //         "refresh_token", profileResponseModel.data!.token!.refresh!);
      //     sharedPreferences!.setString(
      //         "user_id", profileResponseModel.data!.user!.id.toString());
      //     sharedPreferences!.setString("group_id",
      //         profileResponseModel.data!.user!.groups![0].id!.toString());
      //     sharedPreferences!.setString(
      //         "fc_id", profileResponseModel.data!.user!.fCs![0].id.toString());
      //   }
      //   RequestOptions requestOptions = err.requestOptions;
      //   Options options = Options(headers: {
      //     "Content-Type": "application/json",
      //     'Authorization':
      //         'Bearer ${sharedPreferences!.getString("access_token")}',
      //   });

      //   var response = await _dio!.request(requestOptions.path,
      //       data: requestOptions.data,
      //       queryParameters: requestOptions.queryParameters,
      //       options: options);

      //   handler.resolve(response);
      // } else {
      log('Response Decode Data : $decodedData');
      log('Response Code : $responseCode, Error Message : ${err.message}');
      super.onError(err, handler);
      // }
    } else {
      log('No response...${err.message}');
      super.onError(err, handler);
    }
  }
}
