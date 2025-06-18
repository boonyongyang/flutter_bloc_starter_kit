import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Extension to make accessing localization easier throughout the app
extension LocalizationExtension on BuildContext {
  /// Quick access to AppLocalizations
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  /// Quick access to locale
  Locale get locale => Localizations.localeOf(this);

  /// Check if current locale is RTL
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;
}

/// Utility class for localization helpers
class L10nUtils {
  /// Get greeting based on time of day
  static String getGreeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return l10n.goodMorning;
    } else if (hour < 17) {
      return l10n.goodAfternoon;
    } else {
      return l10n.goodEvening;
    }
  }

  /// Format greeting with username
  static String getGreetingWithName(AppLocalizations l10n, String name) {
    final greeting = getGreeting(l10n);
    return l10n.greetingWithName(greeting, name);
  }
}
