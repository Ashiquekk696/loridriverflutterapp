import 'package:flutter/material.dart';
import 'package:loridriverflutterapp/helpers/themes.dart';
import 'package:loridriverflutterapp/pages/forgot_password_page.dart';
import 'package:loridriverflutterapp/pages/login_page.dart';
import 'package:loridriverflutterapp/pages/map_page.dart';
import 'package:loridriverflutterapp/pages/pickup_page.dart';
import 'package:loridriverflutterapp/widgets/bottom_bar_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.light,
        title: 'Flutter Demo',
        theme: Themes().lightTheme,
        darkTheme: Themes().darkTheme,
        home: MainBottomNavBar());
  }
}
