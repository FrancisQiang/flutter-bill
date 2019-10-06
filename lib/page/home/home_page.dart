import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/component/button/animated_floating_button.dart';
import 'package:flutter_bill/component/text/app_bar_text.dart';
import 'package:flutter_bill/config/my_const.dart';
import 'package:flutter_bill/config/my_icons.dart';
import 'package:flutter_bill/model/global_model.dart';
import 'package:flutter_bill/page/chart/chart_page.dart';
import 'package:flutter_bill/page/home/drawer_widget.dart';
import 'package:flutter_bill/page/words/words_page.dart';
import 'package:flutter_bill/util/color_util.dart';
import 'package:flutter_bill/util/provider_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'body.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  Widget _getBottom(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 28.0,
      unselectedItemColor: Colors.black54,
      selectedItemColor: ColorUtil.getLight(Theme.of(context).primaryColor, level: 40),
      backgroundColor: Colors.transparent,
      currentIndex: _currentIndex,
      elevation: 35.0,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        _getBottomItem(icon: Icon(MyIcons.bill), text: 'Bill'),
        _getBottomItem(icon: Icon(MyIcons.chart), text: 'Chart'),
        _getBottomItem(icon: Icon(MyIcons.comments), text: 'Words'),
      ],
    );
  }

  BottomNavigationBarItem _getBottomItem({@required Icon icon, String text}) {
    return BottomNavigationBarItem(
      icon: icon,
      title: Text(
        text,
        style: TextStyle(fontFamily: 'lobster', letterSpacing: 3.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 屏幕适配
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 2340)..init(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          title: AppBarText(MyConst.APP_NAME),
          leading: Builder(
            builder: (context) {
              return Consumer<GlobalModel>(
                builder: (context, globalModel, child) {
                  return FlatButton(
                    child: Icon(Icons.menu, color: ColorUtil.getWhiteOrGrey(globalModel),),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }
              );
            },
          ),
          actions: <Widget>[
            Consumer<GlobalModel>(
              builder: (context, globalModel, child) {
                if (_currentIndex == 2) {
                  return IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 28,
                      color: ColorUtil.getWhiteOrGrey(globalModel),
                    ),
                    onPressed: () {},
                  );
                } else {
                  return IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 28,
                      color: ColorUtil.getWhiteOrGrey(globalModel),
                    ),
                    onPressed: () {},
                  );
                }
              },
            )
          ]
      ),
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeBody(),
          ProviderUtil.getBillModelPage(ChartPage()),
          WordsPage()
        ],
      ),
      bottomNavigationBar: _getBottom(context),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedFloatingButton(),
    );
  }
}


