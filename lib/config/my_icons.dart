import 'package:flutter/material.dart';

class MyIcons {
  static const IconData bill = const _MyIconData(0xe72e);
  static const IconData chart = const _MyIconData(0xe605);
  static const IconData recipes = const _MyIconData(0xe6a2);
  static const IconData user = const _MyIconData(0xea46);
  static const IconData comments = const _MyIconData(0xe615);
}

class _MyIconData extends IconData {
  const _MyIconData(int codePoint)
      : super(
    codePoint,
    fontFamily: 'MyIcons',
  );
}