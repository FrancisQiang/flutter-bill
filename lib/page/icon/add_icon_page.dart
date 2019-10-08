import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/bill_icon_bean.dart';
import 'package:flutter_bill/component/loading/loading_widget.dart';
import 'package:flutter_bill/component/text/app_bar_text.dart';
import 'package:flutter_bill/config/my_const.dart';
import 'package:flutter_bill/model/icon_setting_model.dart';
import 'package:flutter_bill/util/color_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'choose_icon.dart';
import 'local_icon.dart';

class AddIconPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<IconSettingModel>(
      builder: (context, iconSettingModel, child) {
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            centerTitle: true,
            title: AppBarText(
              'Add Icon',
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.check,
                  size: 28,
                ),
                onPressed: () async {
                  BillIconBean billIconBean = BillIconBean();
                  IconBean iconBean = IconBean.fromIconData(iconSettingModel.choosingIconData);
                  billIconBean.iconBean = iconBean;
                  billIconBean.colorBean = ColorUtil.colorToColorBean(Theme.of(context).primaryColor);
                  billIconBean.name = iconSettingModel.choosingIconName;
                  billIconBean.type = iconSettingModel.choosingIconType ? 0 : 1;
                  if (iconSettingModel.choosingIconType) {
                    iconSettingModel.expenseIconList.add(billIconBean);
                    await iconSettingModel.storageExpenseIconList();
                    iconSettingModel.refresh();
                  } else {
                    iconSettingModel.incomeIconList.add(billIconBean);
                    await iconSettingModel.storageIncomeIconList();
                    iconSettingModel.refresh();
                  }
                  Navigator.pop(context);
                },
              )
            ],
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: ScreenUtil.getInstance().setHeight(250),
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.black54, width: 0.3))),
                  child: Row(
                    children: <Widget>[
                      ChooseIcon(iconData: iconSettingModel.choosingIconData),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(30)),
                        height: ScreenUtil.getInstance().setHeight(180),
                        width: ScreenUtil.getInstance().setWidth(600),
                        child: TextField(
                          onChanged: (value) {
                            iconSettingModel.choosingIconName = value;
                          },
                          decoration: InputDecoration(
                              hintText: 'input icon name',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'lobster',
                                  letterSpacing: 1.2),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 0.8))),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setWidth(40)
                        ),
                        child: Switch(
                          activeColor: Theme.of(context).primaryColorDark,
                          value: iconSettingModel.choosingIconType,
                          onChanged: (value) {
                            Fluttertoast.cancel();
                            iconSettingModel.choosingIconType = value;
                            iconSettingModel.refresh();
                            Fluttertoast.showToast(
                                msg: "${iconSettingModel.choosingIconType ? 'Expend' : 'Income'}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.grey[300],
                                textColor: Colors.black87,
                                fontSize: 16.0,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Builder(
                      builder: (context) {
                        if (iconSettingModel.iconBeanList.length == 0) {
                          return FutureBuilder<List<IconBean>>(
                            future: iconSettingModel.getLocalIconList(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return LoadingWidget();
                                case ConnectionState.waiting:
                                  return LoadingWidget();
                                default:
                                  if (snapshot.hasError){
                                    return Icon(Icons.error);
                                  }
                                  else {
                                    return GridView.count(
                                      physics: BouncingScrollPhysics(),
                                      crossAxisCount: 5,
                                      children: List.generate(snapshot.data.length, (index) {
                                        return LocalIcon(
                                          iconBean: snapshot.data[index],
                                        );
                                      }),
                                    );
                                  }
                              }
                            },
                          );
                        }
                        return GridView.count(
                          physics: BouncingScrollPhysics(),
                          crossAxisCount: 5,
                          children: List.generate(iconSettingModel.iconBeanList.length, (index) {
                            return LocalIcon(
                              iconBean: iconSettingModel.iconBeanList[index],
                            );
                          }),
                        );
                      },
                    ),
                  )
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
