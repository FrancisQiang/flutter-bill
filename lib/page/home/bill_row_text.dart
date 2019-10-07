import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillRowText extends StatelessWidget {


  final Widget topChild;
  final Widget bottomChild;
  final double width;

  BillRowText({this.width, this.topChild, this.bottomChild});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(width ?? 300),
      child: Column(
        children: <Widget>[
          topChild,
          Container(
            margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20)),
            child: bottomChild,
          )
        ],
      ),
    );
  }
}