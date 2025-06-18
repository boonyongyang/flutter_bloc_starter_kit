import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:logger/logger.dart';
import 'env.dart';

/// A logger instance for the application.
///
/// This logger uses the PrettyPrinter for formatting log messages and a custom
/// log filter that respects both release mode and environment log level.
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 8,
    lineLength: 150,
    colors: true,
    printEmojis: true,
  ),
  filter: AppLogFilter(),
  level: _getLogLevelFromEnv(),
);

/// Get log level from environment variable
Level _getLogLevelFromEnv() {
  switch (Env.logLevel.toLowerCase()) {
    case 'debug':
      return Level.debug;
    case 'info':
      return Level.info;
    case 'warning':
      return Level.warning;
    case 'error':
      return Level.error;
    default:
      return Level.debug;
  }
}

/// A custom log filter that respects both release mode and environment settings.
///
/// This filter prevents logging in production builds but allows environment-based
/// log level control in development and staging.
class AppLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    // Never log in release mode for production
    if (kReleaseMode && Env.environment == 'prod') {
      return false;
    }

    // In non-production environments, respect the log level
    return !kReleaseMode || Env.environment != 'prod';
  }
}
