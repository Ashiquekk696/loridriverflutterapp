import "package:flutter/material.dart";
import 'package:loridriverflutterapp/helpers/colors.dart';

var toggleSelectedValue = 0;

class CustomToggleWidget extends StatefulWidget {
  CustomToggleWidget(
      {Key? key,
      this.firstLabel,
      this.secondLabel,
      this.onTap,
      required this.onTogle});
  var firstLabel;
  var secondLabel;
  var selectedValue = 0;

  Function(int) onTogle;

  VoidCallback? onTap;
  @override
  State<CustomToggleWidget> createState() => _CustomToggleWidgetState();
}

class _CustomToggleWidgetState extends State<CustomToggleWidget> {
  var labelColor1 = Colors.white;
  var labelColor2 = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFe6ebe8),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      height: 45,
      width: 330,
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  toggleSelectedValue = 0;
                  labelColor1 = Colors.white;
                  widget.onTogle(toggleSelectedValue);
                });
              },
              child: Container(
                height: 50,
                width: 165,
                decoration: BoxDecoration(
                    color: toggleSelectedValue == 0
                        ? Theme.of(context).primaryColor
                        : Color(0xFFe6ebe8),
                    borderRadius: toggleSelectedValue == 0
                        ? BorderRadius.all(Radius.circular(30))
                        : BorderRadius.only(
                            topLeft: Radius.circular(33),
                            bottomLeft: Radius.circular(30))),
                child: Center(
                    child: Text(
                  widget.firstLabel,
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w500,
                      color: toggleSelectedValue == 0
                          ? Colors.white
                          : Colors.black.withOpacity(0.5)),
                )),
              )),
          GestureDetector(
              onTap: () {
                setState(() {
                  toggleSelectedValue = 1;
                  widget.onTogle(toggleSelectedValue);
                });
              },
              child: Container(
                height: 50,
                width: 165,
                decoration: BoxDecoration(
                    color: toggleSelectedValue == 1
                        ? Theme.of(context).primaryColor
                        : Color(0xFFe6ebe8),
                    borderRadius: toggleSelectedValue == 1
                        ? BorderRadius.all(Radius.circular(30))
                        : BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                child: Center(
                    child: Text(
                  widget.secondLabel,
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w500,
                      color: toggleSelectedValue == 1
                          ? Colors.white
                          : Colors.black.withOpacity(0.5)),
                )),
              )),
        ],
      ),
    );
  }
}
