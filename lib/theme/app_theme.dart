import 'package:flutter/material.dart';

class AppTheme {
  static final Color primaryColor = Color(0xFF5C6BC0);
  static final Color secondaryColor = Color(0xFF26A69A);
  static final Color backgroundColor = Colors.white;
  static final Color cardColor = Colors.white;
  static final Color textColor = Color(0xFF424242);
  static final Color lightTextColor = Color(0xFF757575);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true, // Enable Material 3
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      background: backgroundColor,
      surface: cardColor,
      onSurface: textColor,
    ),
    scaffoldBackgroundColor: backgroundColor,
    cardTheme: CardTheme(
      color: cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle( // Updated from headline6
        color: textColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle( // Updated from bodyText1
        color: textColor,
        fontSize: 16,
      ),
      bodyMedium: TextStyle( // Updated from bodyText2
        color: lightTextColor,
        fontSize: 14,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Colors.grey[400]),
    ),
  );
}
