import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_bean.dart';

class BillIconBean {
  int type;
  String name;
  IconBean iconBean;
  ColorBean colorBean;

  BillIconBean({this.name, this.iconBean, this.colorBean, this.type});

  static BillIconBean fromMap(Map<String, dynamic> map) {
    BillIconBean bean = new BillIconBean();
    bean.name = map['name'];
    bean.type = map['type'];
    bean.colorBean = ColorBean.fromJson(map['colorBean']);
    bean.iconBean = IconBean.fromMap(map['iconBean']);
    return bean;
  }

  static List<BillIconBean> fromMapList(dynamic mapList) {
    List<BillIconBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'iconBean': iconBean.toMap(),
      'colorBean': colorBean.toJson()
    };
  }
}

class IconBean {
  int codePoint;
  String fontFamily;
  String fontPackage;
  String iconName;
  bool matchTextDirection;

  IconBean(
      {this.codePoint,
      this.fontFamily,
      this.fontPackage,
      this.iconName,
      this.matchTextDirection});

  static IconData fromBean(IconBean bean) => IconData(bean.codePoint,
      fontFamily: bean.fontFamily,);

  static IconBean fromMap(Map<String, dynamic> map) {
    IconBean bean = new IconBean();
    bean.codePoint = int.parse(map['codePoint']);
    bean.fontFamily = map['fontFamily'];
    bean.fontPackage = map['fontPackage'];
    bean.iconName = map['iconName'];
    bean.matchTextDirection = map['matchTextDirection'] == 'ture';
    return bean;
  }

  static IconBean fromIconData(IconData iconData) {
    return IconBean(
      codePoint: iconData.codePoint,
      fontFamily: iconData.fontFamily,
      fontPackage: iconData.fontPackage,
      matchTextDirection: iconData.matchTextDirection,
    );
  }

  static List<IconBean> fromMapList(dynamic mapList) {
    List<IconBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'codePoint': codePoint.toString(),
      'fontFamily': fontFamily ?? "",
      'fontPackage': fontPackage ?? "",
      'iconName': iconName ?? "",
      'matchTextDirection': matchTextDirection.toString()
    };
  }
}
