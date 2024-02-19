import '../api_export.dart';

class ApiInterceptors extends Interceptor {
  late Dio dio;
  ApiInterceptors(this.dio);

  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // String accessToken =
    //     (GetStorage('USER_STORAGE').read(UserKeys.accessTokenStr) ?? '');

    // if (!isFieldEmpty(accessToken)) {
    //   options.headers[AppConstants.authorizationHeader] =
    //       AppConstants.bearer + accessToken;
    // }
    String headersLog = '';
    options.headers.forEach((k, v) {
      headersLog += '$k: $v\n';
    });
    String reqStr =
        '*** onRequest Start ***\nMethod: ${options.method.toUpperCase()}\nUrl: ${options.baseUrl}${options.path}\nPayload: ${options.data}\nQueryPayload: ${options.queryParameters}\nHeaders:\n$headersLog\n*** onRequest End ***';
    appLog(reqStr, logType: LogType.request);
    super.onRequest(options, handler);
  }

  @override
  Future<dynamic> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    String errorStr =
        '*** onError Start ***\nStatusCode: ${err.response?.statusCode}\n$err\n${err.response}\n*** onError End ***';
    appLog(errorStr, removeDot: true, logType: LogType.error);
    super.onError(err, handler);
  }

  @override
  Future<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    String resStr =
        '*** onResponse Start ***\nStatusCode: ${response.statusCode}\n${response.data}\n*** onResponse End ***';
    appLog(resStr, logType: LogType.response);
    super.onResponse(response, handler);
  }
}
