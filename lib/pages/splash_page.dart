import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loridriverflutterapp/pages/login_page.dart';
import 'package:loridriverflutterapp/widgets/bottom_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  checkLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var isLoggedIn = await preferences.getBool("isLoggedIn");
    setState(() {});

    Timer(Duration(milliseconds: 2500), () {
      (isLoggedIn ?? false)
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => MainBottomNavBar()))
          : Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
//  (isLoggedIn??false)?Navigator.push(context, MaterialPageRoute(builder: (c)))
  }

  @override
  void initState() {
    checkLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset(
              "assets/images/launcher icon.jpg",
              height: 222,
              width: 222,
            ),
          )),
    );
  }
}
