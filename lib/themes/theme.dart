import 'package:flutter/material.dart';

class AvaruusTheme {
  AvaruusTheme._();
  static const _backgroundColor = Color(0xff151515);
  static const _textColor = Color(0xff707070);
  static const _iconColor = Color(0xff404040);
  static const _linkColor = Color(0xff0000EE);
  // static const _linkColor = Color.fromARGB(255, 0, 36, 240);
  static const _defaultTextStyle = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.normal,
    color: _textColor,
    height: 1.1,
  );

  static final ThemeData _theme = ThemeData(
    primaryColor: _textColor,
    primaryColorDark: _iconColor,
    canvasColor: _backgroundColor,

    // Define the default font family.
    fontFamily: 'Bahnschrift',

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Calibri',
        fontSize: 55,
        fontWeight: FontWeight.bold,
        color: Color(0xff1717fc),
        height: 0.9,
      ),
      titleLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: _textColor,
        height: 0.8,
      ),
      titleMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: _textColor,
        height: 0.8,
      ),
      bodyMedium: _defaultTextStyle,
      bodySmall: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
        color: _linkColor,
        // height: 1,
        decoration: TextDecoration.underline,
        
      ),
      labelLarge: _defaultTextStyle,
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: _textColor),
    ),

    // IconButtonTheme requires ThemeData.useMaterial3 = true to work, which breaks other things
    // Therefore IconButton styles will be set individually
    // iconButtonTheme: IconButtonThemeData( 
    //   style: IconButton.styleFrom(
    //     foregroundColor: _iconColor,
    //     iconSize: 30,
    //   ),
    // ),
  );

  static ThemeData get theme => _theme;
}