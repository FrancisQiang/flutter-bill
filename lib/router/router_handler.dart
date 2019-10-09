import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/page/home/home_page.dart';
import 'package:flutter_bill/page/image_picker/avatar_page.dart';
import 'package:flutter_bill/page/net_image_setting/net_image_setting_page.dart';
import 'package:flutter_bill/page/user/user_page.dart';
import 'package:flutter_bill/util/provider_util.dart';

var homeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return HomePage();
  },
);

var themeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return ProviderUtil.getThemePage();
  },
);

var netImageSettingHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return NetImageSettingPage();
  },
);

var userPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return ProviderUtil.getUserPage();
  },
);

var avatarPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return ProviderUtil.getHomeModel(child: AvatarPage());
  },
);

var iconSettingPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return ProviderUtil.getIconSettingPage();
  },
);

var addIconPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return ProviderUtil.getAddIconPage();
  },
);



