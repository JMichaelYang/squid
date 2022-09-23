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

  static final ColorScheme darkThemeColor = ColorScheme.fromSeed(
    seedColor: const Color(0xFF1C234A),
    brightness: Brightness.dark,
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

  static final ColorScheme lightThemeColor = ColorScheme.fromSeed(
    seedColor: const Color(0xFF97DDED),
    brightness: Brightness.light,
  );
}
