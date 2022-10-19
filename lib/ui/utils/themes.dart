import 'package:flutter/material.dart';

class SquidThemes {
  static const String _poppins = 'Poppins';

  // Dark Theme
  static ThemeData getDarkTheme(BuildContext context) {
    return ThemeData.from(
      textTheme: Theme.of(context).textTheme.merge(Typography.whiteMountainView).apply(
            fontFamily: _poppins,
            fontSizeDelta: 2,
          ),
      colorScheme: darkThemeColor,
    );
  }

  static const ColorScheme darkThemeColor = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF86CBD5),
    onPrimary: Colors.black,
    secondary: Color(0xFF1C234A),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.black,
    background: Color(0xFFC1EFFF),
    onBackground: Colors.black,
    surface: Color(0xFFCCE9ED),
    onSurface: Colors.black,
  );

  // Light Theme
  static ThemeData getLightTheme(BuildContext context) {
    return ThemeData.from(
      textTheme: Theme.of(context).textTheme.merge(Typography.blackMountainView).apply(
            fontFamily: _poppins,
            fontSizeDelta: 2,
          ),
      colorScheme: lightThemeColor,
    );
  }

  static const ColorScheme lightThemeColor = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF86CBD5),
    onPrimary: Colors.black,
    secondary: Color(0xFF1C234A),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.black,
    background: Color(0xFFC1EFFF),
    onBackground: Colors.black,
    surface: Color(0xFFCCE9ED),
    onSurface: Colors.black,
  );
}
