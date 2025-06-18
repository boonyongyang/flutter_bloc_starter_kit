import '../config/env.dart';
import '../config/logger.dart';

/// Utility class for application information and environment-aware functionality
class AppInfo {
  static bool isEnv(String env) => Env.environment == env;

  static void logStartupInfo() {
    logger.i('🚀 Starting ${Env.appName}');
    logger.i('🌍 Environment: ${Env.environment}');
    logger.i('📱 App ID: ${Env.appId}');
    logger.i('🔧 Log Level: ${Env.logLevel}');
    logger.i('🌐 API Base URL: ${Env.fruitsApiBaseUrl}');

    final envMsg = {
      'dev': '🛠️ Development mode',
      'stag': '🧪 Staging mode',
      'prod': '🏭 Production mode',
    }[Env.environment];

    if (envMsg != null) {
      (Env.environment == 'prod' ? logger.w : logger.i)(envMsg);
    }
  }

  static String get environmentDisplayName =>
      {
        'dev': 'Development',
        'stag': 'Staging',
        'prod': 'Production',
      }[Env.environment] ??
      'Unknown';
}
