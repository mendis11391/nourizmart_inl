import '../data/api_export.dart';

class ViewCartUseCase {
  final AppRepo appRepo;

  ViewCartUseCase(this.appRepo);

  Future<List<PincodeResponse>> executePincode(payload) async {
    return await appRepo.getPincode(payload);
  }
}
