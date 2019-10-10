import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/bill_icon_bean.dart';
import 'package:flutter_bill/bean/color_bean.dart';
import 'package:flutter_bill/component/dialog/custom_icon_widget.dart';
import 'package:flutter_bill/component/loading/loading_widget.dart';
import 'package:flutter_bill/component/text/app_bar_text.dart';
import 'package:flutter_bill/config/my_const.dart';
import 'package:flutter_bill/model/icon_setting_model.dart';
import 'package:flutter_bill/util/color_util.dart';
import 'package:flutter_bill/util/navigator_util.dart';
import 'package:flutter_bill/util/provider_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'icon_list.dart';

class IconSettingPage extends StatefulWidget {
  @override
  _IconSettingPageState createState() => _IconSettingPageState();
}

class _IconSettingPageState extends State<IconSettingPage> {

  Future initIconList() async {
    await ProviderUtil.iconSettingModel.getAllIconList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initIconList();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<IconSettingModel>(
      builder: (context, iconSettingModel, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: AppBarText('Icon Setting'),
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text(
                      'Expense',
                      style: TextStyle(
                        color: Colors.black54,
                        letterSpacing: 4.0,
                        fontSize: 20.0,
                        fontFamily: "lobster",
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text(
                      'Income',
                      style: TextStyle(
                        color: Colors.black54,
                        letterSpacing: 4.0,
                        fontSize: 20.0,
                        fontFamily: "lobster",
                      ),
                    ),
                  )
                ],
              ),
            ),
            body: Builder(
              builder: (context) {
                if (iconSettingModel.initIconList) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: ScreenUtil.getInstance().setHeight(1750),
                        child: TabBarView(
                          children: <Widget>[
                            IconList(
                              type: MyConst.EXPEND,
                            ),
                            IconList(
                              type: MyConst.INCOME,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: ScreenUtil.getInstance().setWidth(1080),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.black, width: 0.3))),
                          child: Text(
                            '+Add',
                            style: TextStyle(fontSize: 20, letterSpacing: 0.8),
                          ),
                        ),
                        onPressed: () {
                          NavigatorUtil.toAddIconPage(context);
                        },
                      ),
                      )
                    ],
                  );
                } else {
                  return LoadingWidget();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
