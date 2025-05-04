import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_themes.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppThemes.darkTheme);

  void toggleTheme() {
    emit(state == AppThemes.lightTheme
        ? AppThemes.darkTheme
        : AppThemes.lightTheme);
  }
}
