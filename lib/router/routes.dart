import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/router/router_handler.dart';

class Routes {
  static String home = '/home';
  static String theme = '/theme';
  static String netImageSetting = '/netImageSetting';
  static String userPage = '/userPage';
  static String avatarPage = '/avatarPage';
  static String iconSettingPage = '/iconSettingPage';



  static void configureRoutes(Router router) {

    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
          return  null;
        });
    router.define(home, handler: homeHandler, transitionType: TransitionType.cupertino);
    router.define(theme, handler: themeHandler, transitionType: TransitionType.cupertino);
    router.define(netImageSetting, handler: netImageSettingHandler, transitionType: TransitionType.cupertino);
    router.define(userPage, handler: userPageHandler, transitionType: TransitionType.cupertino);
    router.define(avatarPage, handler: avatarPageHandler, transitionType: TransitionType.cupertino);
    router.define(iconSettingPage, handler: iconSettingPageHandler, transitionType: TransitionType.cupertino);
  }
}