import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  ButtonWidget(
      {Key? key,
      required this.onTap,
      this.height,
      this.width,
      this.color,
      this.labelColor,
      this.borderRadius,
      this.fontSize,
      required this.label})
      : super(key: key);
  VoidCallback onTap;
  double? height;
  double? width;
  double? fontSize;
  double? borderRadius;
  var label;
  var labelColor;
  var color;
  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(
                fontFamily: "Montserrat",
                color: widget.labelColor ?? Colors.white,
                fontSize: widget.fontSize ?? 14,
                fontWeight: FontWeight.w500),
          ),
        ),
        height: widget.height ?? 45,
        width: widget.width ?? 200,
        decoration: BoxDecoration(
            color: widget.color ?? Theme.of(context).primaryColor,
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius ?? 30))),
      ),
    );
  }
}
