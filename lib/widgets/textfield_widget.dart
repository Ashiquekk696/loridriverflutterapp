import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {Key? key,
      this.controller,
      required this.image,
      this.label,
      this.obscureText,
      this.validator})
      : super(key: key);
  var controller;
  var label;
  var image;
  bool? obscureText = false;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      validator: validator,
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Colors.red[400],
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          isDense: true,
          prefixIconConstraints: BoxConstraints(minWidth: 0),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          label: Text(
            label,
            style: TextStyle(
                fontSize: 12,
                fontFamily: "Open Sans",
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          prefixIcon: Container(
            transform: Matrix4.translationValues(-12.0, 0.0, 0.0),
            child: IconTheme(
                data: IconThemeData(
                  color: Colors.white,
                ),
                child: IconButton(
                    onPressed: null,
                    icon: Image.asset(
                      image,
                      height: 25,
                      width: 25,
                      color: Colors.white,
                    ))),
          )),
    );
  }
}
