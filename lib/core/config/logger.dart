import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:logger/logger.dart';

/// A logger instance for the application.
///
/// This logger uses the PrettyPrinter for formatting log messages and a custom
/// log filter that only allows logging when the application is not in release mode.
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 8,
    lineLength: 150,
    colors: true,
    printEmojis: true,
  ),
  filter: ProductionLogFilter(),
);

/// A custom log filter that only allows logging when the application is not in release mode.
///
/// This filter is used to prevent logging in production builds.
class ProductionLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return !kReleaseMode;
  }
}
