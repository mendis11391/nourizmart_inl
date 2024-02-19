import '../api_export.dart';

abstract class AppRepo {
  // Future<CommonResponse> getAppVersion(payload);

  Future<UserExistsResponse> checkIfUserExists(String payload);
}
