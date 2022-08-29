import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoriAppBar extends AppBar {
  LoriAppBar()
      : super(
            title: Image.asset(
              "assets/images/headerlogo.png",
              height: 28,
            ),
            centerTitle: true,
            automaticallyImplyLeading: false
            // systemOverlayStyle:
            //     SystemUiOverlayStyle(statusBarColor: Color(0xFF751e78)
            //     )
            );
}
