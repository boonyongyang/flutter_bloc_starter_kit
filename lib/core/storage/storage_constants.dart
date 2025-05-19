// lib/core/storage/storage_constants.dart

class StorageConstants {
  static const String appSettingsBox = 'appSettingsBox';
  static const String firstOpenFlagKey = 'hasOpenedAppBefore';

  // Re-exporting auth box constants if they are defined here
  // or ensure they are accessible if defined elsewhere.
  static const String authBoxName = 'authBox';
  static const String usernameKey = 'username';
  static const String sessionTokenKey =
      'session_token'; // Assuming this is used by secure storage but good to have related keys together if some were in Hive.
}
