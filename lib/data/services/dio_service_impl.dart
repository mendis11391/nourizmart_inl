import 'dart:async';
import 'dart:io';

import '../api_export.dart';

class DioServiceImpl extends GetConnect implements DioService {
  late Dio dio;
  CancelToken cancelToken = CancelToken();

  @override
  void init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: Env.baseurl,
        headers: getAuthorizationHeader(),
        connectTimeout: const Duration(milliseconds: 60000), // 60 sec
        receiveTimeout: const Duration(milliseconds: 60000), // 60 sec
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
      ),
    );
    initializeInterceptor();
  }

  initializeInterceptor() {
    dio.interceptors.add(ApiInterceptors(dio));
  }

  Map<String, dynamic>? getAuthorizationHeader() {
    late dynamic headers = {
      HttpHeaders.acceptHeader: 'application/json',
      AppConstants.mobileHeader: true,
    };
    return headers;
  }

  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  //? *** Get method *** //
  @override
  Future<Response> getRequest(String apiPath,
      {Map<String, dynamic>? queryParameters}) async {
    Response response;
    try {
      response = await dio.get(
        apiPath,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } on SocketException catch (_) {
      throw customThrow('Socket Connection Exception!!!');
    } on FormatException catch (_) {
      throw customThrow('Service unavailable!!!');
    } on TimeoutException catch (_) {
      throw customThrow('Connection Timeout!!!');
    } on DioException catch (e) {
      checkAuthError(e);
      throw AppDioException.createDioError(e);
    }
    return response;
  }

  //? *** Post method *** //
  @override
  Future<Response> postRequest(String apiPath,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    Response response;
    try {
      response = await dio.post(
        apiPath,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } on SocketException catch (_) {
      throw customThrow('Socket Connection Exception!!!');
    } on FormatException catch (_) {
      throw customThrow('Service unavailable!!!');
    } on TimeoutException catch (_) {
      throw customThrow('Connection Timeout!!!');
    } on DioException catch (e) {
      checkAuthError(e);
      throw AppDioException.createDioError(e);
    }
    return response;
  }

  //? *** Put method *** //
  @override
  Future<Response> putRequest(String apiPath,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    Response response;
    try {
      response = await dio.put(
        apiPath,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } on SocketException catch (_) {
      throw customThrow('Socket Connection Exception!!!');
    } on FormatException catch (_) {
      throw customThrow('Service unavailable!!!');
    } on TimeoutException catch (_) {
      throw customThrow('Connection Timeout!!!');
    } on DioException catch (e) {
      checkAuthError(e);
      throw AppDioException.createDioError(e);
    }
    return response;
  }

  //? *** Patch method *** //
  @override
  Future<Response> patchRequest(String apiPath,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    Response response;
    try {
      response = await dio.patch(
        apiPath,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } on SocketException catch (_) {
      throw customThrow('Socket Connection Exception!!!');
    } on FormatException catch (_) {
      throw customThrow('Service unavailable!!!');
    } on TimeoutException catch (_) {
      throw customThrow('Connection Timeout!!!');
    } on DioException catch (e) {
      checkAuthError(e);
      throw AppDioException.createDioError(e);
    }
    return response;
  }

  //? *** Delete method *** //
  @override
  Future<Response> deleteRequest(String apiPath,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    Response response;
    try {
      response = await dio.delete(
        apiPath,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } on SocketException catch (_) {
      throw customThrow('Socket Connection Exception!!!');
    } on FormatException catch (_) {
      throw customThrow('Service unavailable!!!');
    } on TimeoutException catch (_) {
      throw customThrow('Connection Timeout!!!');
    } on DioException catch (e) {
      checkAuthError(e);
      throw AppDioException.createDioError(e);
    }
    return response;
  }

  //? *** PostForm method *** //
  @override
  Future<Response> postFormRequest(String apiPath,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    Response response;
    try {
      response = await dio.post(
        apiPath,
        data: FormData.fromMap(data),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } on SocketException catch (_) {
      throw customThrow('Socket Connection Exception!!!');
    } on FormatException catch (_) {
      throw customThrow('Service unavailable!!!');
    } on TimeoutException catch (_) {
      throw customThrow('Connection Timeout!!!');
    } on DioException catch (e) {
      checkAuthError(e);
      throw AppDioException.createDioError(e);
    }
    return response;
  }

  //? *** PostStream method *** //
  @override
  Future<Response> postStreamRequest(String apiPath,
      {dynamic data,
      int dataLength = 0,
      Map<String, dynamic>? queryParameters}) async {
    Response response;
    Options requestOptions = Options();
    requestOptions.headers!.addAll({
      Headers.contentLengthHeader: dataLength.toString(),
    });
    try {
      response = await dio.post(
        apiPath,
        data: Stream.fromIterable(data.map((e) => [e])),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } on SocketException catch (_) {
      throw customThrow('Socket Connection Exception!!!');
    } on FormatException catch (_) {
      throw customThrow('Service unavailable!!!');
    } on TimeoutException catch (_) {
      throw customThrow('Connection Timeout!!!');
    } on DioException catch (e) {
      checkAuthError(e);
      throw AppDioException.createDioError(e);
    }
    return response;
  }

  AppErrorException customThrow(String msg) {
    return AppErrorException(
      success: false,
      message: msg,
    );
  }

  checkAuthError(DioException e) async {
    var code = e.response != null ? e.response!.statusCode : 0;
    if (code == 401 || code == 403) {
      sessionTimedOut();
    }
  }
}
