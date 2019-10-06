import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/theme_bean.dart';
import 'package:flutter_bill/resource/shared_preferences_keys.dart';
import 'package:flutter_bill/util/shared_util.dart';
import 'color_util.dart';

class ThemeUtil {

  static ThemeData getTheme(ThemeBean themeBean,) {
    return _getThemeData(ColorUtil.colorBeanToColor(themeBean.colorBean), themeBean.themeType);
  }

  static ThemeData _getThemeData(Color color, String themeType) {
    if(themeType == MyTheme.darkTheme){
      return ThemeData(
          brightness: Brightness.dark,
          appBarTheme: getAppBarTheme(Colors.grey));
    }
    return ThemeData(
        primaryColor: color,
        primaryColorDark: ColorUtil.getDark(color),
        primaryColorLight: ColorUtil.getLight(color),
        appBarTheme: getAppBarTheme(Colors.white)
    );
  }


  static AppBarTheme getAppBarTheme(Color color) {
    return AppBarTheme(
        iconTheme: IconThemeData(color: color),
        textTheme: TextTheme(title: TextStyle(color: color, fontSize: 20)));
  }

  static List<ThemeBean> defaultThemeBeans() => [
        ThemeBean(
          themeName: 'Pink',
          colorBean: ColorUtil.colorToColorBean(MyThemeColor.defaultColor),
          themeType: MyTheme.defaultTheme,
        ),
        ThemeBean(
          themeName: 'Black',
          colorBean:  ColorUtil.colorToColorBean(MyThemeColor.darkColor),
          themeType: MyTheme.darkTheme,
        ),
        ThemeBean(
          themeName: 'Coffee',
          colorBean:  ColorUtil.colorToColorBean(MyThemeColor.coffeeColor),
          themeType: MyTheme.coffeeTheme,
        ),
        ThemeBean(
          themeName: 'Green',
          colorBean:  ColorUtil.colorToColorBean(MyThemeColor.greenColor),
          themeType: MyTheme.greenTheme,
        ),
        ThemeBean(
          themeName: 'Purple',
          colorBean:  ColorUtil.colorToColorBean(MyThemeColor.purpleColor),
          themeType: MyTheme.purpleTheme,
        ),
        ThemeBean(
          themeName: 'Cyan',
          colorBean:  ColorUtil.colorToColorBean(MyThemeColor.cyanColor),
          themeType: MyTheme.cyanTheme,
        ),
        ThemeBean(
          themeName: 'BlueGray',
          colorBean:  ColorUtil.colorToColorBean(MyThemeColor.blueGrayColor),
          themeType: MyTheme.blueGrayTheme,
        ),
      ];


  static Future<List<ThemeBean>> getThemeListFromDisk() async{
    List<String> stringList = await SharedUtil.instance.getStringList(SharedPreferencesKeys.THEME_BEANS);
    List<ThemeBean> list = [];
    if (stringList != null && stringList.isNotEmpty) {
      for (var o in stringList) {
        final data = jsonDecode(o);
        ThemeBean themeBean = ThemeBean.fromMap(data);
        list.add(themeBean);
      }
    }
    final defaultList = defaultThemeBeans();
    // 返回用户添加和默认的
    return List.from(defaultList + list);
  }
}

class MyTheme {
  static const String defaultTheme = "Pink";
  static const String darkTheme = "Black";
  static const String coffeeTheme = "Coffee";
  static const String cyanTheme = "Cyan";
  static const String purpleTheme = "Purple";
  static const String greenTheme = "Green";
  static const String blueGrayTheme = "BlueGray";
}

class MyThemeColor {
  static const Color defaultColor = Color.fromRGBO(246, 200, 200, 1);
  static const Color darkColor = Colors.grey;
  static const Color coffeeColor = Color.fromRGBO(228, 183, 160, 1);
  static const Color cyanColor = Color.fromRGBO(143, 227, 235, 1);
  static const Color greenColor = Color.fromRGBO(151, 215, 178, 1);
  static const Color purpleColor = Color.fromRGBO(205, 188, 255, 1);
  static const Color blueGrayColor = Color.fromRGBO(135, 170, 171, 1);
}
