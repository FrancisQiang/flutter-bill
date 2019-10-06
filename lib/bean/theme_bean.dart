import 'color_bean.dart';

class ThemeBean {

  String themeName;
  ColorBean colorBean;
  String themeType;

  ThemeBean({this.themeName, this.colorBean, this.themeType});

  static ThemeBean fromMap(Map<String, dynamic> map) {
    ThemeBean bean = new ThemeBean();
    bean.themeName = map['themeName'];
    bean.colorBean = ColorBean.fromJson(map['colorBean']);
    bean.themeType = map['themeType'];
    return bean;
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'themeName': themeName,
      'colorBean': colorBean.toJson(),
      'themeType': themeType
    };
  }
}
