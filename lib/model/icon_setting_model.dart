import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bill/bean/bill_icon_bean.dart';
import 'package:flutter_bill/resource/shared_preferences_keys.dart';
import 'package:flutter_bill/util/color_util.dart';
import 'package:flutter_bill/util/shared_util.dart';
import 'package:flutter_bill/util/theme_util.dart';

class IconSettingModel with ChangeNotifier {

  // 默认的收入列表
  List<BillIconBean> _incomeIconList = [
    BillIconBean(
        name: 'work',
        type: 1,
        iconBean: IconBean.fromIconData(Icons.work),
        colorBean: ColorUtil.colorToColorBean(MyThemeColor.coffeeColor)),
    BillIconBean(
        name: 'bonus',
        type: 1,
        iconBean: IconBean.fromIconData(Icons.monetization_on),
        colorBean: ColorUtil.colorToColorBean(MyThemeColor.greenColor)),
    BillIconBean(
        name: 'red packet',
        type: 1,
        iconBean: IconBean.fromIconData(Icons.score),
        colorBean: ColorUtil.colorToColorBean(MyThemeColor.blueGrayColor)
    ),
    BillIconBean(
        name: 'business',
        type: 1,
        iconBean: IconBean.fromIconData(Icons.business_center),
        colorBean: ColorUtil.colorToColorBean(MyThemeColor.purpleColor)
    ),
    BillIconBean(
        name: 'appericate',
        type: 1,
        iconBean: IconBean.fromIconData(Icons.thumb_up),
        colorBean: ColorUtil.colorToColorBean(MyThemeColor.cyanColor)
    ),
    BillIconBean(
        name: 'borrow',
        type: 1,
        iconBean: IconBean.fromIconData(Icons.people_outline),
        colorBean: ColorUtil.colorToColorBean(MyThemeColor.darkColor)
    ),
  ];

  // 默认的支出列表
  List<BillIconBean> _expenseIconList = [
    BillIconBean(
        name: 'food',
        type: 0,
        iconBean: IconBean.fromIconData(Icons.local_dining),
        colorBean: ColorUtil.colorToColorBean(MyThemeColor.coffeeColor)),
    BillIconBean(
        name: 'game',
        type: 0,
        iconBean: IconBean.fromIconData(Icons.videogame_asset),
        colorBean: ColorUtil.colorToColorBean(MyThemeColor.cyanColor)),
    BillIconBean(
        name: 'study',
        type: 0,
        iconBean: IconBean.fromIconData(Icons.book),
        colorBean: ColorUtil.colorToColorBean(MyThemeColor.defaultColor)),
    BillIconBean(
        name: 'gift',
        type: 0,
        iconBean: IconBean.fromIconData(Icons.card_giftcard),
        colorBean: ColorUtil.colorToColorBean(MyThemeColor.greenColor)),
    BillIconBean(
        name: 'travel',
        type: 0,
        iconBean: IconBean.fromIconData(Icons.drive_eta),
        colorBean: ColorUtil.colorToColorBean(MyThemeColor.darkColor)),
    BillIconBean(
        name: 'hairdressing',
        type: 0,
        iconBean: IconBean.fromIconData(Icons.face),
        colorBean: ColorUtil.colorToColorBean(MyThemeColor.blueGrayColor)),
  ];


  List<BillIconBean> get incomeIconList => this._incomeIconList;

  set incomeIconList(List<BillIconBean> value) {
    _incomeIconList = value;
  }

  List<BillIconBean> get expenseIconList => this._expenseIconList;

  set expenseIconList(List<BillIconBean> value) {
    _expenseIconList = value;
  }

  void storageIncomeIconList() async {
    List<String> stringList = [];
    _incomeIconList.forEach((billIconBean) {
      String str = jsonEncode(billIconBean.toMap());
      stringList.add(str);
    });
    await SharedUtil.instance.saveStringList(SharedPreferencesKeys.INCOME_ICON_LIST, stringList);
  }

  void storageExpenseIconList() async {
    List<String> stringList = [];
    _expenseIconList.forEach((billIconBean) {
      String str = jsonEncode(billIconBean.toMap());
      stringList.add(str);
    });
    await SharedUtil.instance.saveStringList(SharedPreferencesKeys.EXPENSE_ICON_LIST, stringList);
  }

  Future<List<BillIconBean>> getExpenseIconWithCache() async{
    List<String> stringList = await SharedUtil.instance.getStringList(SharedPreferencesKeys.EXPENSE_ICON_LIST);
    if (stringList != null && stringList.length > 0) {
      // 首先清除
      _expenseIconList.clear();
      for (var o in stringList) {
        final data = jsonDecode(o);
        BillIconBean expenseIconBean = BillIconBean.fromMap(data);
        _expenseIconList.add(expenseIconBean);
      }
    } else {
      stringList = [];
      _expenseIconList.forEach((billIconBean) {
        String str = jsonEncode(billIconBean.toMap());
        stringList.add(str);
      });
      await SharedUtil.instance.saveStringList(SharedPreferencesKeys.EXPENSE_ICON_LIST, stringList);
    }
    return _expenseIconList;
  }

  Future<List<BillIconBean>> getIncomeIconWithCache() async{
    List<String> stringList = await
    SharedUtil.instance.getStringList(SharedPreferencesKeys.INCOME_ICON_LIST);
    if (stringList != null && stringList.length > 0) {
      _incomeIconList.clear();
      for (var o in stringList) {
        final data = jsonDecode(o);
        BillIconBean taskIconBean = BillIconBean.fromMap(data);
        _incomeIconList.add(taskIconBean);
      }
    } else {
      stringList = [];
      _incomeIconList.forEach((billIconBean) {
        String str = jsonEncode(billIconBean.toMap());
        stringList.add(str);
      });
      await SharedUtil.instance.saveStringList(SharedPreferencesKeys.INCOME_ICON_LIST, stringList);
    }
    return _incomeIconList;
  }

  Future<List<IconBean>> getLocalIconList() async {
    String json = await rootBundle.loadString('assets/json/icon_json.json');
    return IconBean.fromMapList(jsonDecode(json));
  }

  refresh() {
    notifyListeners();
  }

}