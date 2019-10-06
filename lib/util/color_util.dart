import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/color_bean.dart';
import 'package:flutter_bill/model/global_model.dart';
import 'package:flutter_bill/util/theme_util.dart';

class ColorUtil {

  static Color colorBeanToColor(ColorBean bean) =>
      Color.fromRGBO(bean.red, bean.green, bean.blue, bean.opacity);

  static ColorBean mapToColorBean(Map<String, dynamic> map) {
    ColorBean bean = ColorBean();
    bean.red = int.parse(map['red']);
    bean.green = int.parse(map['green']);
    bean.blue = int.parse(map['blue']);
    bean.opacity = double.parse(map['opacity']);
    return bean;
  }

  static ColorBean colorToColorBean(Color color) {
    ColorBean colorData = ColorBean();
    colorData.opacity = color.opacity;
    colorData.red = color.red;
    colorData.green = color.green;
    colorData.blue = color.blue;
    return colorData;
  }

  static Color getDark(Color color, {int level = 30}) {
    int red = color.red - level <= 0 ? color.red : color.red - level;
    int green = color.green - level <= 0 ? color.green : color.green - level;
    int blue = color.blue - level <= 0 ? color.blue : color.blue - level;
    return Color.fromRGBO(red, green, blue, 1);
  }

  static Color getLight(Color color, {int level = 30}) {
    int red = color.red + level >= 255 ? color.red : color.red + level;
    int green = color.green + level >= 255 ? color.green : color.green + level;
    int blue = color.blue + level >= 255 ? color.blue : color.blue + level;
    return Color.fromRGBO(red, green, blue, 1);
  }

  static getWhiteOrGrey(GlobalModel globalModel, {int greyLevel = 400}){
    final themeType = globalModel.currentThemeBean.themeType;
    return themeType == MyTheme.darkTheme ? Colors.grey[greyLevel] : Colors.white70;
  }

}