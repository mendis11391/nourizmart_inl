import 'package:get_storage/get_storage.dart';

initUserStorage() async {
  await GetStorage.init('USER_STORAGE');
}

getUserStorage() {
  return GetStorage('USER_STORAGE');
}

saveStorageValue(String key, dynamic value) async =>
    await getUserStorage().write(key, value);

getStorageValue(String key, {dynamic defaultValue}) async =>
    await getUserStorage().read(key);

removeStorageValue(String key) async {
  if (await getStorageValue(key) != null) {
    await getUserStorage().remove(key);
  }
}
