import 'package:flutter/material.dart';

// purple theme
const PrimarySwatchColor = MaterialColor(
  0xFFAD0A64,
  <int, Color>{
    50: Color(0xFFFCE4EC),
    100: Color(0xFFF8BBD0),
    200: Color(0xFFF48FB1),
    300: Color(0xFFF06292),
    400: Color(0xFFEC407A),
    500: Color(0xFFE91E63),
    600: Color(0xFFD81B60),
    700: Color(0xFFC2185B),
    800: Color(0xFFAD1457),
    900: Color(0xFF880E4F),
  },
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: PrimarySwatchColor,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: PrimarySwatchColor,
  accentColor: PrimarySwatchColor,
);
