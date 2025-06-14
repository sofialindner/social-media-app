import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media_app/presentation/themes/colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Poppins',
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 246, 246, 246),
    primary: AppColors.primaryColor,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.grey.shade800,
    ),
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.grey.shade800,
    surfaceTintColor: Colors.transparent,
  ),
  textTheme: TextTheme(
    bodySmall: TextStyle(
      color: Colors.grey.shade900,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      color: Colors.grey.shade900,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: TextStyle(
      color: Colors.grey.shade900,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      //letterSpacing: 0.1
    ),
    titleLarge: TextStyle(
      color: Colors.grey.shade900,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
      fontSize: 24,
    ),
    headlineMedium: TextStyle(
      color: Colors.grey.shade900,
      fontSize: 13,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      color: Colors.grey.shade800,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
  ),
);
