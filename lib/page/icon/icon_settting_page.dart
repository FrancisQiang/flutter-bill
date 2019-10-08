import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/bill_icon_bean.dart';
import 'package:flutter_bill/component/text/app_bar_text.dart';
import 'package:flutter_bill/util/icon_list_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: AppBarText(
              'Icon Setting'
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Container(
                child: FlatButton(
                  onPressed: () {},
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
              ),
              Container(
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Income',
                    style: TextStyle(
                      color: Colors.black54,
                      letterSpacing: 4.0,
                      fontSize: 20.0,
                      fontFamily: "lobster",
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomSheet: FlatButton(
          padding: EdgeInsets.all(0.0),
          child: Container(
            alignment: Alignment.center,
            height: ScreenUtil.getInstance().setHeight(160),
            width: ScreenUtil.getInstance().setWidth(1080),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: Colors.black,
                        width: 0.4
                    )
                )
            ),
            child: Text(
              '+Add',
              style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.8
              ),
            ),
          ),
          onPressed: () {},
        ),
        body: TabBarView(
          children: <Widget>[
            ListView.separated(
              separatorBuilder: (context, index) {
                return Container(
                  width: ScreenUtil.getInstance().setWidth(1080),
                  height: ScreenUtil.getInstance().setHeight(1),
                  color: Colors.black54,
                );
              },
              itemCount: IconListUtil.expenseIconList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: ScreenUtil.getInstance().setHeight(150),
                  margin: EdgeInsets.symmetric(
                      vertical: ScreenUtil.getInstance().setHeight(40)
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.red[400],
                            shape: BoxShape.circle
                        ),
                        margin: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(30),
                            right: ScreenUtil.getInstance().setWidth(45)
                        ),
                        width: ScreenUtil.getInstance().setWidth(60),
                        height: ScreenUtil.getInstance().setWidth(60),
                        child: Icon(
                          CupertinoIcons.clear_thick,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[400].withOpacity(0.5),
                            shape: BoxShape.circle
                        ),
                        margin: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(10)
                        ),
                        width: ScreenUtil.getInstance().setWidth(120),
                        height: ScreenUtil.getInstance().setWidth(120),
                        child: Icon(
                          IconBean.fromBean(IconListUtil.expenseIconList[index].iconBean),
                          color: Colors.black54,
                        ),
                      ),
                      Container(
                        width: ScreenUtil.getInstance().setWidth(500),
                        margin: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(50)
                        ),
                        child: Text(
                          IconListUtil.expenseIconList[index].name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              letterSpacing: 0.5
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(150)
                        ),
                        child: Icon(
                          Icons.menu,
                          color: Colors.grey[300],
                        ),
                      )
                    ],
                  ),
                );
              },
              physics: BouncingScrollPhysics(),
            ),
            ListView.separated(
              separatorBuilder: (context, index) {
                return Container(
                  width: ScreenUtil.getInstance().setWidth(1080),
                  height: ScreenUtil.getInstance().setHeight(1),
                  color: Colors.black54,
                );
              },
              itemCount: IconListUtil.incomeIconList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: ScreenUtil.getInstance().setHeight(150),
                  margin: EdgeInsets.symmetric(
                      vertical: ScreenUtil.getInstance().setHeight(40)
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.red[400],
                            shape: BoxShape.circle
                        ),
                        margin: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(30),
                            right: ScreenUtil.getInstance().setWidth(45)
                        ),
                        width: ScreenUtil.getInstance().setWidth(60),
                        height: ScreenUtil.getInstance().setWidth(60),
                        child: Icon(
                          CupertinoIcons.clear_thick,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[400].withOpacity(0.5),
                            shape: BoxShape.circle
                        ),
                        margin: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(10)
                        ),
                        width: ScreenUtil.getInstance().setWidth(120),
                        height: ScreenUtil.getInstance().setWidth(120),
                        child: Icon(
                          IconBean.fromBean(IconListUtil.incomeIconList[index].iconBean),
                          color: Colors.black54,
                        ),
                      ),
                      Container(
                        width: ScreenUtil.getInstance().setWidth(500),
                        margin: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(50)
                        ),
                        child: Text(
                          IconListUtil.incomeIconList[index].name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              letterSpacing: 0.5
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(150)
                        ),
                        child: Icon(
                          Icons.menu,
                          color: Colors.grey[300],
                        ),
                      )
                    ],
                  ),
                );
              },
              physics: BouncingScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}
