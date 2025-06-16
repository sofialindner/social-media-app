import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media_app/presentation/themes/colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Poppins',
  colorScheme: ColorScheme.light(
    surface: Color.fromARGB(255, 246, 246, 246),
    primary: AppColors.lightPrimaryColor,
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
      fontWeight: FontWeight.w600,
      fontSize: 36,
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
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      backgroundColor: AppColors.lightPrimaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12.0),
      ),
    ),
  ),
);
