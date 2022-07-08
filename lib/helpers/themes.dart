import 'package:flutter/material.dart';

class Themes {
  var lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFF751e78),
    appBarTheme: const AppBarTheme(color: Color(0xFF751e78)),
    textTheme: const TextTheme(
      displaySmall: const TextStyle(color: Colors.black, fontSize: 20),
      displayMedium: TextStyle(color: Colors.black, fontSize: 20),
      displayLarge: TextStyle(color: Colors.black, fontSize: 17),
      titleMedium: TextStyle(
          fontSize: 16,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w500,
          letterSpacing: 0),
    ),
  );

  var darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.purple,
    primaryColor: Colors.lightGreen,
    appBarTheme: const AppBarTheme(color: Colors.purple),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.purple,
        backgroundColor: Colors.purple,
        selectedLabelStyle: TextStyle(color: Colors.lightGreen)),
  );
}
