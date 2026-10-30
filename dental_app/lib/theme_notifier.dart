import 'package:flutter/material.dart';

final ValueNotifier<bool> isDarkModeNotifier = ValueNotifier<bool>(false);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF00BFA5),
  scaffoldBackgroundColor: const Color(0xFFF8F9FA),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF00BFA5),
    brightness: Brightness.light,
  ),
  useMaterial3: true,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF00BFA5),
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF00BFA5),
    brightness: Brightness.dark,
  ).copyWith(
    surface: const Color(0xFF1E1E1E),
  ),
  useMaterial3: true,
);
