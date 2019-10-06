import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/theme_bean.dart';
import 'package:flutter_bill/resource/shared_preferences_keys.dart';
import 'package:flutter_bill/util/color_util.dart';
import 'package:flutter_bill/util/shared_util.dart';
import 'package:flutter_bill/util/theme_util.dart';
import 'package:flutter_colorpicker/material_picker.dart';

class ThemePageModel with ChangeNotifier {

  Color _customColor = Colors.black;

  List<ThemeBean> _themeList = [];

  bool _deleting = false;

  void getThemeList() async {
    final list = await ThemeUtil.getThemeListFromDisk();
    _themeList.clear();
    _themeList.addAll(list);
    if(list.length == 7){
      _deleting = false;
    }
    refresh();
  }

  void createCustomTheme(context) {
    _showColorPicker(context);
  }

  void _showColorPicker(context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            elevation: 0.0,
            title: Text('选取颜色'),
            content: SingleChildScrollView(
              child: MaterialPicker(
                pickerColor: Theme.of(context).primaryColor,
                onColorChanged: (color) {
                  _customColor = color;
                },
                enableLabel: true,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  '取消',
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('ok'),
                onPressed: () async {
                  List<String> beans = await SharedUtil.instance.getStringList(SharedPreferencesKeys.THEME_BEANS) ?? [];
                  if (beans.length >= 10) {
                    _showCanNotAddTheme(context);
                    return;
                  }
                  ThemeBean themeBean = ThemeBean(
                    themeName: 'custom' +
                        " ${beans.length + 1}",
                    themeType: 'custom' +
                        " ${beans.length + 1}",
                    colorBean: ColorUtil.colorToColorBean(_customColor)
                  );
                  final data = jsonEncode(themeBean.toMap());
                  beans.add(data);
                  SharedUtil.instance.saveStringList(SharedPreferencesKeys.THEME_BEANS, beans);
                  getThemeList();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _showCanNotAddTheme(context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content:
            Text('You can''t add a theme anymore',style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500, fontFamily: 'lobster'),),
          );
        });
  }

  removeIcon(int index) {
    SharedUtil.instance.removeListItem(SharedPreferencesKeys.THEME_BEANS,index - 7);
    getThemeList();
  }

  @override
  void dispose(){
    super.dispose();
  }

  void refresh(){
    notifyListeners();
  }

  Color get customColor => this._customColor;

  set customColor(Color value) => this._customColor = value;

  List<ThemeBean> get themeList => this._themeList;

  set themeList(List<ThemeBean> value) => this._themeList = value;

  bool get deleting => this._deleting;

  set deleting(bool value) => this._deleting = value;

}