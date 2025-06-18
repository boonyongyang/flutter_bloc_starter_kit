import '../config/env.dart';
import '../config/logger.dart';

/// Utility class for application information and environment-aware functionality
class AppInfo {
  /// Check if the app is running in development environment
  static bool get isDevelopment => Env.environment == 'dev';

  /// Check if the app is running in staging environment
  static bool get isStaging => Env.environment == 'stag';

  /// Check if the app is running in production environment
  static bool get isProduction => Env.environment == 'prod';

  /// Log application startup information
  static void logStartupInfo() {
    logger.i('🚀 Starting ${Env.appName}');
    logger.i('🌍 Environment: ${Env.environment}');
    logger.i('📱 App ID: ${Env.appId}');
    logger.i('🔧 Log Level: ${Env.logLevel}');
    logger.i('🌐 API Base URL: ${Env.fruitsApiBaseUrl}');

    if (isDevelopment) {
      logger.d('🛠️ Running in development mode - all features enabled');
    } else if (isStaging) {
      logger.i('🧪 Running in staging mode - testing configuration');
    } else if (isProduction) {
      logger.w('🏭 Running in production mode - minimal logging');
    }
  }

  /// Get a user-friendly environment name
  static String get environmentDisplayName {
    switch (Env.environment) {
      case 'dev':
        return 'Development';
      case 'stag':
        return 'Staging';
      case 'prod':
        return 'Production';
      default:
        return 'Unknown';
    }
  }
}
