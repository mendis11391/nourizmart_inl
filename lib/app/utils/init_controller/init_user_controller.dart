import '../../../data/models/get_user_res_mod.dart';
import '../app_export.dart';

class UserDataController extends GetxController {
  var firstName = ''.obs,
      lastName = ''.obs,
      mobile = ''.obs,
      houseNo = ''.obs,
      street = ''.obs,
      stateName = ''.obs,
      districtName = ''.obs,
      pincode = ''.obs,
      areaName = ''.obs,
      landmark = ''.obs,
      addressId = 0.obs,
      pincodeId = 0.obs,
      fullAddress = ''.obs;

  loadUserData() async {
    if (await getStorageValue(UserKeys.userModel) != null) {
      final userModel =
          userResponseSingleFromJson(await getStorageValue(UserKeys.userModel));

      firstName.value = validString(userModel.firstName);
      lastName.value = validString(userModel.lastName);
      mobile.value = validString(userModel.mobile);
      houseNo.value = validString(userModel.houseNo);
      street.value = validString(userModel.street);
      stateName.value = validString(userModel.stateName);
      districtName.value = validString(userModel.districtName);
      pincode.value = validString(userModel.pincode);
      areaName.value = validString(userModel.areaName);
      landmark.value = validString('');
      addressId.value = validInt(0);
      pincodeId.value = validInt(userModel.pincodeId);

      String address = '';
      if (!isFieldEmpty(houseNo.value)) {
        address += houseNo.value;
      }
      if (!isFieldEmpty(street.value)) {
        if (address.isNotEmpty) {
          address += ', ';
        }
        address += street.value;
      }
      if (!isFieldEmpty(areaName.value)) {
        if (address.isNotEmpty) {
          address += ', ';
        }
        address += areaName.value;
      }
      if (!isFieldEmpty(districtName.value)) {
        if (address.isNotEmpty) {
          address += ', ';
        }
        address += districtName.value;
      }
      if (!isFieldEmpty(stateName.value)) {
        if (address.isNotEmpty) {
          address += ', ';
        }
        address += stateName.value;
      }
      if (!isFieldEmpty(pincode.value)) {
        if (address.isNotEmpty) {
          address += ', ';
        }
        address += pincode.value;
      }

      fullAddress.value = address;
    }
  }
}
