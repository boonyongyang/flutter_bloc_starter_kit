import 'package:flutter/material.dart';
import '../theme/app_themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = AppThemes.lightTheme;

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    if (_currentTheme == AppThemes.lightTheme) {
      _currentTheme = AppThemes.darkTheme;
    } else {
      _currentTheme = AppThemes.lightTheme;
    }
    notifyListeners();
  }
}
