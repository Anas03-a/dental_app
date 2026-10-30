import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'language_notifier.dart';
import 'theme_notifier.dart';

void main() {
  runApp(const DentalApp());
}

class DentalApp extends StatelessWidget {
  const DentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isArabicNotifier,
      builder: (context, isArabic, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: isDarkModeNotifier,
          builder: (context, isDark, child) {
            return MaterialApp(
              title: 'Dental App',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              builder: (context, child) {
                return Directionality(
                  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                  child: child!,
                );
              },
              home: const MainScreen(),
            );
          },
        );
      },
    );
  }
}
