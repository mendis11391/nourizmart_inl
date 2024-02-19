import '../app_export.dart';
// import '../../../data/models/profile_res_mod.dart' as profile_res;

class UserDataController extends GetxController {
  var userId = 0.obs,
      userName = ''.obs,
      firstName = ''.obs,
      lastName = ''.obs,
      mobile = ''.obs,
      email = ''.obs;

  // loadUserData() async {
  //   final userModel = profile_res
  //       .profileResponseFromJson(await getStorageValue(UserKeys.userModel));
  //   userId.value = validInt(userModel.id);
  //   userName.value = validString(userModel.username);
  //   firstName.value = validString(userModel.firstName);
  //   lastName.value = validString(userModel.lastName);
  //   mobile.value = validString(userModel.mobileNo);
  //   email.value = validString(userModel.email);
  // }
}
