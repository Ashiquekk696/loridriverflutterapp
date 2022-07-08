import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      width: 110,
      child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
        strokeWidth: 20,
        valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
      ),
    );
  }
}
