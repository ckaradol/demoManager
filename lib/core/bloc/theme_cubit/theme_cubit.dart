import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system) {
    _loadTheme();
  }

  /// SharedPreferences'tan tema tercihini yükle
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString("themeMode") ?? "system";

    switch (saved) {
      case "light":
        emit(ThemeMode.light);
        break;
      case "dark":
        emit(ThemeMode.dark);
        break;
      default:
        emit(ThemeMode.system);
    }
  }

  /// Tema değiştir (light, dark, system)
  Future<void> setTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();

    switch (mode) {
      case ThemeMode.light:
        await prefs.setString("themeMode", "light");
        break;
      case ThemeMode.dark:
        await prefs.setString("themeMode", "dark");
        break;
      default:
        await prefs.setString("themeMode", "system");
    }

    emit(mode);
  }
}
