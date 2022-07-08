import 'package:flutter/rendering.dart';

var text = TextStyle();

class TextStyles {
  styleBolded({fontSize, color}) {
    var textStyle = TextStyle(
        fontSize: fontSize,
        color: color,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w700,
        letterSpacing: 0);

    return textStyle;
  }

  styleMediumBold() {
    var textStyle = TextStyle(
        fontSize: 16,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w500,
        letterSpacing: 0);
  }

  subTitle({double? fontSize, color, FontWeight? fontWeight}) {
    var textStyle = TextStyle(
        fontSize: fontSize,
        color: color,
        fontFamily: "Montserrat",
        fontWeight: fontWeight ?? FontWeight.w500,
        letterSpacing: 0);

    return textStyle;
  }

  subTitleOpenSans({double? fontSize, color, FontWeight? fontWeight}) {
    var textStyle = TextStyle(
        fontSize: fontSize,
        color: color,
        fontFamily: "Open Sans",
        fontWeight: fontWeight ?? FontWeight.w500,
        letterSpacing: 0);

    return textStyle;
  }
}
