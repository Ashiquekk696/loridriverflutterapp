import 'package:flutter/material.dart';

class Themes {
  var lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    //  primaryColor: Color(0xFF751e78),

    primaryColor: Color(0XFF73308a),
    appBarTheme: const AppBarTheme(color: Color(0XFF73308a)),
    textTheme: const TextTheme(
      displaySmall: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: "Avenir Next LT Pro Regular",
      ),
      displayMedium: TextStyle(
          fontFamily: "Avenir Next LT Pro Regular",
          color: Colors.black,
          fontSize: 20),
      displayLarge: TextStyle(color: Colors.black, fontSize: 17),
      titleMedium: TextStyle(
          fontSize: 16,
          fontFamily: "MonAvenir Next LT Pro Regulartserrat",
          fontWeight: FontWeight.w500,
          letterSpacing: 0),
    ),
  );

  var darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0XFF73308a),
    primaryColor: Color(0XFF89dc65),
    appBarTheme: const AppBarTheme(
      color: Color(0XFF73308a),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color(0XFF73308a),
        backgroundColor: Color(0XFF73308a),
        selectedLabelStyle: TextStyle(
            fontFamily: "Avenir Next LT Pro Regular",
            color: Color(0XFF89dc65))),
  );
}
