import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'IBMPlexSansArabic',
  scaffoldBackgroundColor: colors.background,
  primaryColor: colors.primary,
  
  appBarTheme: AppBarTheme(
    backgroundColor: colors.background,
    foregroundColor: Color.fromARGB(0, 0, 0, 0),
  ),


  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
);
