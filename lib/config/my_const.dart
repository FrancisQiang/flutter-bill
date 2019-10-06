import 'package:flutter/material.dart';
class MyConst{
  // App 名称 (title)
  static const String APP_NAME = "Flutter Bill";
  // 每日一图的url
  static const String DAILY_PIC_URL = 'https://api.dujin.org/bing/1366.php';


  // 列表颜色交替
  static final List<Color> iconColorList = [
    Colors.red[200],
    Colors.orange[200],
    Colors.green[200],
    Colors.cyan[200],
    Colors.blue[200],
    Colors.purple[200],
    Colors.indigoAccent[200],
    Colors.pinkAccent[200],
    Colors.amber[200],
    Colors.indigo[200],
  ];

  /// icon
  static const String ICON_FAMILY = 'MaterialIcons';

  /// 支出为0
  static const int EXPEND = 0;

  /// 收入为1
  static const int INCOME = 1;

  /// 头像的heroTag
  static const String AVATAR_HERO_TAG = 'avatar';
}