import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/bill_icon_bean.dart';
import 'package:flutter_bill/bean/color_bean.dart';
import 'package:flutter_bill/component/dialog/custom_icon_widget.dart';
import 'package:flutter_bill/config/my_const.dart';
import 'package:flutter_bill/model/icon_setting_model.dart';
import 'package:flutter_bill/util/color_util.dart';
import 'package:flutter_bill/util/provider_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class IconList extends StatelessWidget {
  final int type;

  IconList({this.type});

  void editIconColor({ColorBean colorBean, int index, BuildContext context}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              elevation: 0.0,
              contentPadding:
                  EdgeInsets.all(ScreenUtil.getInstance().setWidth(30)),
              title: Center(
                child: Text(
                  'Custom Color',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 28.0,
                      letterSpacing: 1.5,
                      fontFamily: 'lobster'),
                ),
              ),
              content: CustomIconWidget(
                onApplyTap: (color) async {
                  ProviderUtil.iconSettingModel.currentChoosingColor = color;
                  ColorBean localColorBean = ColorUtil.colorToColorBean(
                      ProviderUtil.iconSettingModel.currentChoosingColor);
                  if (type == MyConst.EXPEND) {
                    ProviderUtil.iconSettingModel.expenseIconList[index]
                        .colorBean = localColorBean;
                    ProviderUtil.iconSettingModel.refresh();
                    await ProviderUtil.iconSettingModel
                        .storageExpenseIconList();
                  } else {
                    ProviderUtil.iconSettingModel.incomeIconList[index]
                        .colorBean = localColorBean;
                    ProviderUtil.iconSettingModel.refresh();
                    await ProviderUtil.iconSettingModel.storageIncomeIconList();
                  }
                },
                pickerColor: colorBean == null
                    ? ProviderUtil.iconSettingModel.currentChoosingColor
                    : ColorUtil.colorBeanToColor(colorBean),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IconSettingModel>(
      builder: (context, iconSettingModel, child) {
        return ListView.separated(
          separatorBuilder: (context, index) {
            return Container(
              width: ScreenUtil.getInstance().setWidth(1080),
              height: ScreenUtil.getInstance().setHeight(1),
              color: Colors.black54,
            );
          },
          itemCount: type == MyConst.EXPEND
              ? iconSettingModel.expenseIconList.length
              : iconSettingModel.incomeIconList.length,
          itemBuilder: (context, index) {
            BillIconBean billIconBean;
            if (type == MyConst.EXPEND) {
              billIconBean = iconSettingModel.expenseIconList[index];
            } else {
              billIconBean = iconSettingModel.incomeIconList[index];
            }
            return Container(
              height: ScreenUtil.getInstance().setHeight(180),
              margin: EdgeInsets.symmetric(
                  vertical: ScreenUtil.getInstance().setHeight(40)),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setWidth(30),
                          right: ScreenUtil.getInstance().setWidth(45)),
                      child: Icon(
                        Icons.color_lens,
                        color: Colors.grey[400],
                      ),
                    ),
                    onTap: () {
                      editIconColor(
                        colorBean:
                            iconSettingModel.incomeIconList[index].colorBean,
                        index: index,
                        context: context,
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300].withOpacity(0.5),
                        shape: BoxShape.circle),
                    margin: EdgeInsets.only(
                        left: ScreenUtil.getInstance().setWidth(10)),
                    width: ScreenUtil.getInstance().setWidth(120),
                    height: ScreenUtil.getInstance().setWidth(120),
                    child: Icon(
                      IconBean.fromBean(billIconBean.iconBean),
                      color: ColorUtil.colorBeanToColor(billIconBean.colorBean),
                    ),
                  ),
                  Container(
                    width: ScreenUtil.getInstance().setWidth(500),
                    margin: EdgeInsets.only(
                        left: ScreenUtil.getInstance().setWidth(50)),
                    child: Text(
                      billIconBean.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          letterSpacing: 0.5),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (type == MyConst.EXPEND) {
                        iconSettingModel.expenseIconList.removeAt(index);
                        iconSettingModel.storageExpenseIconList();
                        iconSettingModel.refresh();
                      } else {
                        iconSettingModel.incomeIconList.removeAt(index);
                        iconSettingModel.storageIncomeIconList();
                        iconSettingModel.refresh();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red[400], shape: BoxShape.circle),
                      margin: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setWidth(150)),
                      width: ScreenUtil.getInstance().setWidth(60),
                      height: ScreenUtil.getInstance().setWidth(60),
                      child: Icon(
                        CupertinoIcons.clear_thick,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          physics: BouncingScrollPhysics(),
        );
      },
    );
  }
}
