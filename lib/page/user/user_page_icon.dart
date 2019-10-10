import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserPageIcon extends StatelessWidget {

  final IconData iconData;

  final double size;

  final Color color;

  final String name;

  UserPageIcon({@required this.iconData, @required this.size, @required this.color, @required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Icon(iconData, color: color, size: size,),
          Container(
            margin: EdgeInsets.only(
                top: ScreenUtil.getInstance().setHeight(10)
            ),
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'lobster',
                  fontSize: 15,
                  letterSpacing: 2.5
              ),
            ),
          )
        ],
      ),
    );
  }
}
