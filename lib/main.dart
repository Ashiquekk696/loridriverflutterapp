import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loridriverflutterapp/helpers/themes.dart';
import 'package:loridriverflutterapp/pages/forgot_password_page.dart';
import 'package:loridriverflutterapp/pages/login_page.dart';
import 'package:loridriverflutterapp/pages/map_page.dart';
import 'package:loridriverflutterapp/pages/pickup_page.dart';
import 'package:loridriverflutterapp/pages/splash_page.dart';
import 'package:loridriverflutterapp/widgets/bottom_bar_widget.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        title: 'Lori Drivers',
        theme: Themes().lightTheme,
        darkTheme: Themes().darkTheme,
        home: SplashPage());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
