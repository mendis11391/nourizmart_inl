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

  @EnviedField(varName: 'API_VERSION_PATH')
  static final String apiVersionPath = _Env.apiVersionPath;

  @EnviedField(varName: 'API_USER_EXISTS')
  static final String apiUserExistsPath = _Env.apiUserExistsPath;

  @EnviedField(varName: 'API_REGISTER_USER')
  static final String apiRegisterPath = _Env.apiRegisterPath;

    @EnviedField(varName: 'API_PROFILE')
  static final String apiProfilePath = _Env.apiProfilePath;

  static final String baseurl = stagingServer;
  // static final String appVersion = '$v2$apiVersionPath';
  static final String userExists = '$customerPath$apiUserExistsPath';
  static final String register = '$customerPath$apiRegisterPath';
  static final String profile = '$customerPath$apiProfilePath';
}
