import 'package:envied/envied.dart';

part 'env.g.dart';

// flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

@Envied(path: 'lock.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'STAGING_SERVER')
  static final String stagingServer = _Env.stagingServer;

  @EnviedField(varName: 'PRODUCTION_SERVER')
  static final String productionServer = _Env.productionServer;

  @EnviedField(varName: 'API_CUSTOMER')
  static final String customerPath = _Env.customerPath;

  @EnviedField(varName: 'API_ADMIN')
  static final String adminPath = _Env.adminPath;

  @EnviedField(varName: 'API_VERSION_PATH')
  static final String apiVersionPath = _Env.apiVersionPath;

  @EnviedField(varName: 'API_USER_EXISTS')
  static final String apiUserExistsPath = _Env.apiUserExistsPath;

  @EnviedField(varName: 'API_PROFILE')
  static final String apiProfilePath = _Env.apiProfilePath;

  @EnviedField(varName: 'API_STATES')
  static final String apiStatePath = _Env.apiStatePath;

  @EnviedField(varName: 'API_DISTRICT')
  static final String apiDistrictPath = _Env.apiDistrictPath;

  @EnviedField(varName: 'API_PINCODES')
  static final String apiPincodePath = _Env.apiPincodePath;

  @EnviedField(varName: 'API_AREAS')
  static final String apiAreaPath = _Env.apiAreaPath;

  @EnviedField(varName: 'API_REGISTRATION')
  static final String apiRegistrationPath = _Env.apiRegistrationPath;

  static final String baseurl = stagingServer;
  // static final String appVersion = '$v2$apiVersionPath';
  static final String userExists = '$customerPath$apiUserExistsPath';
  static final String allState = '$adminPath$apiStatePath';
  static final String district = '$adminPath$apiDistrictPath';
  static final String pincode = '$adminPath$apiPincodePath';
  static final String area = '$adminPath$apiAreaPath';
  static final String registration = '$customerPath$apiRegistrationPath';
  static final String profile = '$customerPath$apiProfilePath';
}
