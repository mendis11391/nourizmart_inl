
import '../data/api_export.dart';

class RegisterUseCase {
  final AppRepo appRepo;

  RegisterUseCase(this.appRepo);

  Future<StateResponse> executeState() async {
    return await appRepo.getAllState();
  }

  Future<List<DistrictResponse>> executeDistrict(payload) async {
    return await appRepo.getDistrict(payload);
  }

  // Future<PincodeResponse> executePincode(payload) async {
  //   return await appRepo.getPincode(payload);
  // }

  // Future<AreaResponse> executeArea(payload) async {
  //   return await appRepo.getArea(payload);
  // }

  Future<List<PincodeResponse>> executePincode(payload) async {
    return await appRepo.getPincode(payload);
  }

  Future<List<AreaResponse>> executeArea(payload) async {
    return await appRepo.getArea(payload);
  }
  
  Future<RegistrationResponse> executeRegistration(payload) async {
    return await appRepo.getRegistration(payload);
  }
}
