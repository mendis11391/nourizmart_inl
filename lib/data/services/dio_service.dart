import 'package:dio/dio.dart';

abstract class DioService {
  // init dia basic options
  void init();

  // Get request method
  Future<Response> getRequest(String apiPath,
      {Map<String, dynamic>? queryParameters});

  // Post request method
  Future<Response> postRequest(String apiPath,
      {dynamic data, Map<String, dynamic>? queryParameters});

  // Put request method
  Future<Response> putRequest(String apiPath,
      {dynamic data, Map<String, dynamic>? queryParameters});

  // Patch request method
  Future<Response> patchRequest(String apiPath,
      {dynamic data, Map<String, dynamic>? queryParameters});

  // Delete request method
  Future<Response> deleteRequest(String apiPath,
      {dynamic data, Map<String, dynamic>? queryParameters});

  // postForm request method
  Future<Response> postFormRequest(String apiPath,
      {dynamic data, Map<String, dynamic>? queryParameters});

  // post Stream request method
  Future<Response> postStreamRequest(String apiPath,
      {dynamic data,
      int dataLength = 0,
      Map<String, dynamic>? queryParameters});
}
