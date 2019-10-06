import 'package:flutter/material.dart';

class AppBarText extends StatelessWidget {
  final String _text;

  AppBarText(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          letterSpacing: 2.5,
          fontSize: 28.0,
          fontFamily: "lobster"),
    );
  }
}
