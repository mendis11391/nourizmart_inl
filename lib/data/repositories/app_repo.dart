import '../api_export.dart';

abstract class AppRepo {
  // Future<CommonResponse> getAppVersion(payload);

  Future<UserExistsResponse> checkIfUserExists(String payload);

  Future<List<UserResponse>> getUserInfo(payload);

  Future<StateResponse> getAllState();

  Future<List<DistrictResponse>> getDistrict(payload);

  // Future<PincodeResponse> getPincode(payload);

  // Future<AreaResponse> getArea(payload);

  Future<List<PincodeResponse>> getPincode(payload);

  Future<List<AreaResponse>> getArea(payload);

  Future<RegistrationResponse> getRegistration(payload);
}
