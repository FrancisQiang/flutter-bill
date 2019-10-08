import 'package:flutter/material.dart';
import 'package:flutter_bill/router/application.dart';
import 'package:flutter_bill/router/routes.dart';

class NavigatorUtil {

  static void toHomePage(BuildContext context) {
    Application.router.navigateTo(context, Routes.home, replace: true);
  }

  static void toThemePage(BuildContext context) {
    Application.router.navigateTo(context, Routes.theme);
  }

  static void toNetImageSetting(BuildContext context) {
    Application.router.navigateTo(context, Routes.netImageSetting);
  }

  static void toUserPage(BuildContext context) {
    Application.router.navigateTo(context, Routes.userPage);
  }

  static void toAvatarPage(BuildContext context) {
    Application.router.navigateTo(context, Routes.avatarPage);
  }

  static void toIconSettingPage(BuildContext context) {
    Application.router.navigateTo(context, Routes.iconSettingPage);
  }

}
