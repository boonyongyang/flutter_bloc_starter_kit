import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'ENV')
  static const String environment = _Env.environment;

  @EnviedField(varName: 'FRUITS_API_BASE_URL')
  static const String fruitsApiBaseUrl = _Env.fruitsApiBaseUrl;

  @EnviedField(varName: 'APP_ID')
  static const String appId = _Env.appId;

  @EnviedField(varName: 'APP_NAME')
  static const String appName = _Env.appName;

  @EnviedField(varName: 'LOG_LEVEL')
  static const String logLevel = _Env.logLevel;
}
