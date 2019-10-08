import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseIcon extends StatelessWidget {

  final IconData iconData;

  ChooseIcon({this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle),
      margin: EdgeInsets.only(
          left: ScreenUtil.getInstance().setWidth(45),
          right: ScreenUtil.getInstance().setWidth(45)),
      width: ScreenUtil.getInstance().setWidth(130),
      height: ScreenUtil.getInstance().setWidth(130),
      child: Icon(
        iconData,
        color: Colors.black87,
        size: 24,
      ),
    );
  }
}
