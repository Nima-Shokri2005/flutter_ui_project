import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  final Color surfaceColor;
  final Color scaffoldBackgroundColor;
  final Color appBarColor;
  final Color iconColor;
  final Brightness brightness;

  ThemeConfig.dark()
      : surfaceColor = const Color(0x0dffffff),
        scaffoldBackgroundColor = const Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        iconColor = Colors.white,
        brightness = Brightness.dark;

  ThemeConfig.light()
      : surfaceColor = const Color(0x0d000000),
        scaffoldBackgroundColor = Colors.white,
        appBarColor = const Color.fromARGB(255, 200, 200, 200),
        iconColor = Colors.black,
        brightness = Brightness.light;

  ThemeData getTheme(String localeLanguage) {
    return ThemeData(
        useMaterial3: true,
        iconTheme: IconThemeData(color: iconColor),
        brightness: brightness,
        dividerColor: surfaceColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(backgroundColor: appBarColor),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: surfaceColor,
        ),
        textTheme: localeLanguage == 'en' ? enPrimaryFont : faPrimaryFont);
  }

  TextTheme get enPrimaryFont => GoogleFonts.latoTextTheme(
        const TextTheme(
          bodyLarge: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  TextTheme get faPrimaryFont => const TextTheme(
        bodyMedium: TextStyle(fontFamily: 'iranyekan'),
        bodyLarge:
            TextStyle(fontWeight: FontWeight.bold, fontFamily: 'iranyekan'),
      );
}
