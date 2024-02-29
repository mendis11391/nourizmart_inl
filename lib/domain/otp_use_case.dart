import '../data/api_export.dart';

class OtpUseCase {
  final AppRepo appRepo;

  OtpUseCase(this.appRepo);

  Future<UserExistsResponse> executeUserExists(payload) async {
    return await appRepo.checkIfUserExists(payload);
  }

  Future<List<UserResponse>> executeUserInfo(payload) async {
    return await appRepo.getUserInfo(payload);
  }
}
