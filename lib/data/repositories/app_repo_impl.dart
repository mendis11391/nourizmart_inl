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

  @override
  Future<List<UserResponse>> getUserInfo(payload) async {
    // return await dioService
    //     .getRequest(Env.profile + payload)
    //     .then((response) => UserResponse.fromJson(jsonDecode(response.data)));

    return await dioService.getRequest(Env.profile + payload).then((response) =>
        (jsonDecode(response.data) as List)
            .map((item) => UserResponse.fromJson(item))
            .toList());
  }

  @override
  Future<StateResponse> getAllState() async {
    return await dioService
        .getRequest(Env.allState)
        .then((response) => StateResponse.fromJson(jsonDecode(response.data)));
  }

  // @override
  // Future<DistrictResponse> getDistrict(payload) async {
  //   return await dioService.getRequest(Env.district + payload).then(
  //       (response) => DistrictResponse.fromJson(jsonDecode(response.data)));
  // }

  @override
  Future<List<DistrictResponse>> getDistrict(payload) async {
    final response = await dioService.getRequest(Env.district + payload);

    final list = (jsonDecode(response.data) as List)
        .map((item) => DistrictResponse.fromJson(item))
        .toList();

    return list;
  }

  // @override
  // Future<PincodeResponse> getPincode(payload) async {
  //   return await dioService.getRequest(Env.pincode + payload).then(
  //       (response) => PincodeResponse.fromJson(jsonDecode(response.data)));
  // }

  @override
  Future<List<PincodeResponse>> getPincode(payload) async {
    final response = await dioService.getRequest(Env.pincode + payload);

    final list = (jsonDecode(response.data) as List)
        .map((item) => PincodeResponse.fromJson(item))
        .toList();

    return list;
  }

  // @override
  // Future<AreaResponse> getArea(payload) async {
  //   return await dioService
  //       .getRequest(Env.area + payload)
  //       .then((response) => AreaResponse.fromJson(jsonDecode(response.data)));
  // }

  @override
  Future<List<AreaResponse>> getArea(payload) async {
    final response = await dioService.getRequest(Env.area + payload);

    final list = (jsonDecode(response.data) as List)
        .map((item) => AreaResponse.fromJson(item))
        .toList();

    return list;
  }

  @override
  Future<RegistrationResponse> getRegistration(payload) async {
    return await dioService
        .postRequest(Env.registration, data: jsonEncode(payload))
        .then((response) =>
            RegistrationResponse.fromJson(jsonDecode(response.data)));
  }
}
