import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  // i dont change this file *****
  scaffoldBackgroundColor: colors.background,
  primaryColor: colors.primary,
  appBarTheme: AppBarTheme(
    backgroundColor: colors.background,
    foregroundColor: Color.fromARGB(0, 0, 0, 0),
  ),
  textTheme: TextTheme(
   
  ),
);
