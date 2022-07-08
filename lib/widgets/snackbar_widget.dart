import 'package:flutter/material.dart';

showSnackBar({context, text}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
      content: Text(
        text,
        textAlign: TextAlign.center,
      )));
}
