import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loridriverflutterapp/helpers/themes.dart';
import '../helpers/colors.dart';

var text = TextStyle();

class TextStyles {
  styleBolded({dynamic fontSize, color}) {
    var textStyle = TextStyle(
        fontSize: fontSize,
        color: color,
        fontFamily: "Avenir Next LT Pro Regular",
        fontWeight: FontWeight.w800,
        letterSpacing: 0);

    return textStyle;
  }

  styleMediumBold() {
    var textStyle = TextStyle(
        fontSize: 16,
        fontFamily: "Avenir Next LT Pro Regular",
        fontWeight: FontWeight.w500,
        letterSpacing: 0);
  }

  subTitle({double? fontSize, color, FontWeight? fontWeight}) {
    var textStyle = TextStyle(
        fontSize: fontSize ?? 17,
        color: color,
        fontFamily: "Avenir LT Std",
        fontWeight: fontWeight ?? FontWeight.w500,
        letterSpacing: 0);

    return textStyle;
  }

  mainAppStyle({double? fontSize, color, FontWeight? fontWeight}) {
    var textStyle = TextStyle(
        fontSize: fontSize ?? 11,
        color: color,
        fontFamily: "Avenir Next LT Pro Regular",
        fontWeight: fontWeight ?? FontWeight.w600,
        letterSpacing: 0);

    return textStyle;
  }

  minititle({double? fontSize, color, FontWeight? fontWeight, context}) {
    var textStyle = TextStyle(
        fontSize: fontSize ?? 14,
        color: color ?? Theme.of(context).primaryColor,
        fontFamily: "Avenir Next LT Pro Regular",
        fontWeight: fontWeight ?? FontWeight.w600,
        letterSpacing: 0);

    return textStyle;
  }
}
