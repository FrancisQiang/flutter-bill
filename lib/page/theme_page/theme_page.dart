import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/theme_bean.dart';
import 'package:flutter_bill/component/switcher/custom_animated_switcher.dart';
import 'package:flutter_bill/component/text/app_bar_text.dart';
import 'package:flutter_bill/model/global_model.dart';
import 'package:flutter_bill/model/theme_page_model.dart';
import 'package:flutter_bill/resource/shared_preferences_keys.dart';
import 'package:flutter_bill/util/color_util.dart';
import 'package:flutter_bill/util/shared_util.dart';
import 'package:flutter_bill/util/theme_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ThemePageModel>(context)..getThemeList();
    final globalModel = Provider.of<GlobalModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppBarText('Theme Setting'),
        actions: <Widget>[
          model.themeList.length > 7
              ? CustomAnimatedSwitcher(
                  firstChild: IconButton(
                    icon: Icon(
                      Icons.border_color,
                      size: 20.0,
                      color: ColorUtil.getWhiteOrGrey(globalModel),
                    ),
                    onPressed: null,
                  ),
                  secondChild: IconButton(
                    icon: Icon(
                      Icons.check,
                      size: 20.0,
                      color: ColorUtil.getWhiteOrGrey(globalModel),
                    ),
                    onPressed: null,
                  ),
                  hasChanged: model.deleting,
                  onTap: () {
                    model.deleting = !model.deleting;
                    model.refresh();
                  },
                )
              : SizedBox(),
        ],
      ),
      floatingActionButton: AbsorbPointer(
        absorbing: model.deleting,
        child: Opacity(
          opacity: model.deleting ? 0 : 1,
          child: InkWell(
            onTap: () {
              model.createCustomTheme(context);
            },
            child: Container(
              height: ScreenUtil.getInstance().setWidth(200),
              width: ScreenUtil.getInstance().setWidth(200),
              alignment: Alignment.center,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Colors.redAccent,
                    Colors.greenAccent,
                    Colors.blueAccent,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        alignment: Alignment.topCenter,
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          children: List.generate(model.themeList.length, (index) {
            final themeBean = model.themeList[index];
            return Stack(
              children: <Widget>[
                AbsorbPointer(
                  absorbing: model.deleting,
                  child:
                      getThemeBloc(themeBean, globalModel),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: AbsorbPointer(
                    absorbing: model.deleting ? false : true,
                    child: Opacity(
                      opacity: (index > 6 && model.deleting) ? 1.0 : 0.0,
                      child: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => model.removeIcon(index),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget getThemeBloc(ThemeBean themeBean, GlobalModel globalModel) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      onTap: () {
        globalModel.currentThemeBean = themeBean;
        globalModel.refresh();
        SharedUtil.instance.saveString(SharedPreferencesKeys.CURRENT_THEME_BEAN,
            jsonEncode(themeBean.toMap()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil.getInstance().setWidth(40),
            vertical: ScreenUtil.getInstance().setHeight(80)),
        alignment: Alignment.center,
        child: Text(
          themeBean.themeName,
          style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'lobster', letterSpacing: 1.5),
        ),
        decoration: BoxDecoration(
            color: themeBean.themeType == MyTheme.darkTheme
                ? Colors.black
                : ColorUtil.colorBeanToColor(themeBean.colorBean),
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
