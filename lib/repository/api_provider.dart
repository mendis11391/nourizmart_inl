import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../exceptions/dio_exception.dart';
import '../utils/utils.dart';
import 'logging_interceptor.dart';

class ApiProvider {
  Dio? dio;
  ApiProvider() {
    BaseOptions options = BaseOptions(
        receiveTimeout: Duration(milliseconds: 30000),
        connectTimeout: Duration(milliseconds: 30000));
    dio = Dio(options);
    dio!.interceptors.add(LoggingInterceptor());
  }

  SharedPreferences? pref;

  Future<dynamic> get(String url, String urlType,
      {Map<String, String>? headers}) async {
    pref = await SharedPreferences.getInstance();

    var responseJson;
    try {
      if (headers == null) {
        headers = {
          "Content-Type": "application/json",
          // 'Authorization': 'Bearer ${pref!.getString("access_token")}',
        };
      }
      final response = await dio!.get(getBaseUrlFromUrlType(urlType) + url,
          options: Options(headers: headers));
      responseJson = _returnResponse(response);
    } on DioException catch (e) {
      throw AppDioException.createDioError(e);
    }
    return responseJson;
  }

  Future<dynamic> post(String url, String urlType, dynamic body,
      {Map<String, String>? headers}) async {
    var responseJson;
    pref = await SharedPreferences.getInstance();
    try {
      if (headers == null) {
        headers = {
          "Content-Type": "application/json",
          // 'Authorization': 'Bearer ${pref!.getString("access_token")}',
        };
      }
      final response = await dio!.post(getBaseUrlFromUrlType(urlType) + url,
          data: body, options: Options(headers: headers));
      responseJson = _returnResponse(response);
    } on DioException catch (e) {
      throw AppDioException.createDioError(e);
    }
    return responseJson;
  }

  Future<dynamic> put(String url, String urlType, dynamic body,
      {Map<String, String>? headers}) async {
    var responseJson;
    pref = await SharedPreferences.getInstance();
    try {
      if (headers == null) {
        headers = {
          "Content-Type": "application/json",
          // 'Authorization': 'Bearer ${pref!.getString("access_token")}',
        };
      }
      final response = await dio!.put(getBaseUrlFromUrlType(urlType) + url,
          data: body, options: Options(headers: headers));
      responseJson = _returnResponse(response);
    } on DioException catch (e) {
      throw AppDioException.createDioError(e);
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, String urlType) async {
    var apiResponse;
    try {
      final response = await dio!.delete(getBaseUrlFromUrlType(urlType) + url);
      apiResponse = _returnResponse(response);
    } on DioException catch (e) {
      throw AppDioException.createDioError(e);
    }
    return apiResponse;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.toString());
        return responseJson;
      case 201:
        var responseJson = json.decode(response.toString());
        return responseJson;
      case 400:
        var responseJson = json.decode(response.toString());
        return responseJson;
      case 401:
        throw Exception(response.toString());
      case 403:
        throw Exception(response.toString());
      case 500:
      default:
        throw Exception(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
