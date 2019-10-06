import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/theme_bean.dart';
import 'package:flutter_bill/resource/shared_preferences_keys.dart';
import 'package:flutter_bill/util/color_util.dart';
import 'package:flutter_bill/util/shared_util.dart';
import 'package:flutter_bill/util/theme_util.dart';

class GlobalModel with ChangeNotifier{

  ThemeBean _currentThemeBean = ThemeBean(
    themeName: "pink",
    colorBean: ColorUtil.colorToColorBean(MyThemeColor.defaultColor),
    themeType: MyTheme.defaultTheme,
  );

  ThemeBean get currentThemeBean => this._currentThemeBean;

  set currentThemeBean(ThemeBean value) {
    this._currentThemeBean = value;
  }

  // 抽屉的图片地址
  String _currentNetPicUrl = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568007837508&di=7871c6af0c0d4023e9d43aa74fa754cb&imgtype=0&src=http%3A%2F%2Fimg4q.duitang.com%2Fuploads%2Fitem%2F201404%2F21%2F20140421201545_jkJrU.jpeg";

  String get currentNetPicUrl => _currentNetPicUrl;

  Future<String> getCurrentNetPicUrlFromCache() async {
    String currentNetPicUrl = await SharedUtil.instance.getString(SharedPreferencesKeys.CURRENT_NET_PICTURE_URL);
    if (currentNetPicUrl != null) {
      _currentNetPicUrl = currentNetPicUrl;
    }
    return _currentNetPicUrl;
  }

  set currentNetPicUrl(String url) => this._currentNetPicUrl = url;

  bool _isDaily = true;

  bool get isDaily => this._isDaily;

  Future<bool> getIsDaily() async {
    bool isDailyFromCache = await SharedUtil.instance.getBoolean(SharedPreferencesKeys.IS_DAILY);
    if (isDailyFromCache != null) {
      _isDaily = isDailyFromCache;
    }
    return _isDaily;
  }

  setDaily(bool value) {
    this._isDaily = value;
    SharedUtil.instance.saveBoolean(SharedPreferencesKeys.IS_DAILY, _isDaily);
  }

  Future getCurrentTheme() async{
    final theme = await SharedUtil.instance.getString(SharedPreferencesKeys.CURRENT_THEME_BEAN);
    if(theme == null) return;
    ThemeBean themeBean = ThemeBean.fromMap(jsonDecode(theme));
    if(themeBean.themeType == currentThemeBean.themeType) return;
    currentThemeBean = themeBean;
    notifyListeners();
  }

  refresh() {
    notifyListeners();
  }


}