import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/component/text/app_bar_text.dart';
import 'package:flutter_bill/config/my_const.dart';
import 'package:flutter_bill/model/global_model.dart';
import 'package:flutter_bill/util/navigator_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ImageSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppBarText('Image Setting'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
          width: ScreenUtil.getInstance().setWidth(1080),
          child: Consumer<GlobalModel>(
            builder: (context, globalModel, _) {
              return Column(
                children: <Widget>[
                  _getImageRow(
                      isDaily: true,
                      globalModel: globalModel,
                      context: context),
                  _getImageRow(
                      isDaily: false,
                      globalModel: globalModel,
                      context: context),
                ],
              );
            },
          )),
    );
  }

  Widget _getImageRow(
      {bool isDaily, GlobalModel globalModel, BuildContext context}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      width: ScreenUtil.getInstance().setWidth(1080),
      decoration: BoxDecoration(),
      margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(300)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: ScreenUtil.getInstance().setWidth(210),
            child: Text(
              isDaily ? 'daily' : 'network',
              style: TextStyle(
                fontFamily: 'lobster',
                fontSize: 15.0,
                letterSpacing: 1.5,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 0.0),
            height: ScreenUtil.getInstance().setHeight(470),
            width: ScreenUtil.getInstance().setWidth(540),
            child: GestureDetector(
              onTap: () {
                if (isDaily) {
                  globalModel.setDaily(!globalModel.isDaily);
                } else {
                  NavigatorUtil.toNetImageSetting(context);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    image: DecorationImage(
                        image: NetworkImage(
                          isDaily
                              ? MyConst.DAILY_PIC_URL
                              : globalModel.currentNetPicUrl,
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 5.0),
            child: Checkbox(
              value: isDaily ? globalModel.isDaily : !globalModel.isDaily,
              onChanged: (value) {
                if (isDaily) {
                  globalModel.setDaily(value);
                } else {
                  globalModel.setDaily(!value);
                }
                globalModel.refresh();
              },
              activeColor: Theme.of(context).primaryColorDark,
            ),
          )
        ],
      ),
    );
  }
}
