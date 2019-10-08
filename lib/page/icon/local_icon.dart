import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/bill_icon_bean.dart';
import 'package:flutter_bill/model/icon_setting_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LocalIcon extends StatelessWidget {

  final IconBean iconBean;

  LocalIcon({@required this.iconBean});

  @override
  Widget build(BuildContext context) {
    return Consumer<IconSettingModel>(
      builder: (context, iconSettingModel, child) {
        return GestureDetector(
          onTap: () {
            iconSettingModel.choosingIconData = IconBean.fromBean(iconBean);
            iconSettingModel.refresh();
          },
          child: Container(
            decoration: BoxDecoration(
                color: iconSettingModel.choosingIconData.codePoint == iconBean.codePoint
                    ? Theme.of(context).primaryColor : Colors.grey[300],
                shape: BoxShape.circle),
            margin: EdgeInsets.only(
                left: ScreenUtil.getInstance().setWidth(45),
                right: ScreenUtil.getInstance().setWidth(45)),
            width: ScreenUtil.getInstance().setWidth(130),
            height: ScreenUtil.getInstance().setWidth(130),
            child: Icon(
              IconBean.fromBean(iconBean),
              color: Colors.black87,
              size: 24,
            ),
          ),
        );
      },
    );
  }
}
