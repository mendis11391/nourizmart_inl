import '../api_export.dart';

class AppRepoImpl extends GetConnect implements AppRepo {
  late DioService dioService;

  AppRepoImpl() {
    dioService = Get.find<DioServiceImpl>();
    dioService.init();
  }

  // @override
  // Future<CommonResponse> getAppVersion(payload) async {
  //   return await dioService
  //       .postRequest(Env.appVersion, data: jsonEncode(payload))
  //       .then((response) => CommonResponse.fromJson(jsonDecode(response.data)));
  // }

  @override
  Future<UserExistsResponse> checkIfUserExists(payload) async {
    return await dioService.getRequest(Env.userExists + payload).then(
        (response) => UserExistsResponse.fromJson(jsonDecode(response.data)));
  }
}
