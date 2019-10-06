import 'package:flutter/material.dart';
import 'package:flutter_bill/component/clip/rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil.getInstance().setWidth(25),
              vertical: ScreenUtil.getInstance().setHeight(30)
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            elevation: 10.0,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(
                            ScreenUtil.getInstance().setWidth(50)
                        ),
                        height: ScreenUtil.getInstance().setWidth(180),
                        width: ScreenUtil.getInstance().setWidth(180),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('assets/images/avatar.jpg'),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Container(
                        width: ScreenUtil.getInstance().setWidth(450),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                '瘦瘦瘦',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '2019-10-6',
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 15
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: RatingBar(
                          value: 9,
                          size: 14,
                          padding: 2.5,
                          normalImage: 'assets/images/star_normal.png',
                          selectImage: 'assets/images/star.png',
                          maxRating: 10.0,
                          count: 5,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: ScreenUtil.getInstance().setWidth(50),
                      bottom: ScreenUtil.getInstance().setHeight(80)
                    ),
                    width: ScreenUtil.getInstance().setWidth(850),
                    child: Text(
                      '拉速度快就发了可视对讲焚枯食淡明年持续，线程可视对讲里看电视是登录开发D发索拉卡代付款圣诞节螺丝刀',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil.getInstance().setWidth(25),
                vertical: ScreenUtil.getInstance().setHeight(30)
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            elevation: 10.0,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(
                            ScreenUtil.getInstance().setWidth(50)
                        ),
                        height: ScreenUtil.getInstance().setWidth(180),
                        width: ScreenUtil.getInstance().setWidth(180),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('assets/images/avatar.jpg'),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Container(
                        width: ScreenUtil.getInstance().setWidth(450),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                '瘦瘦瘦',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '2019-10-6',
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 15
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: RatingBar(
                          value: 9,
                          size: 14,
                          padding: 2.5,
                          normalImage: 'assets/images/star_normal.png',
                          selectImage: 'assets/images/star.png',
                          maxRating: 10.0,
                          count: 5,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil.getInstance().setWidth(50),
                        bottom: ScreenUtil.getInstance().setHeight(80)
                    ),
                    width: ScreenUtil.getInstance().setWidth(850),
                    child: Text(
                      '拉速度快就发了可视对讲焚枯食淡明年持续，线程可视对讲里看电视是登录开发D发索拉卡代付款圣诞节螺丝刀',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil.getInstance().setWidth(25),
                vertical: ScreenUtil.getInstance().setHeight(30)
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            elevation: 10.0,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(
                            ScreenUtil.getInstance().setWidth(50)
                        ),
                        height: ScreenUtil.getInstance().setWidth(180),
                        width: ScreenUtil.getInstance().setWidth(180),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('assets/images/avatar.jpg'),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Container(
                        width: ScreenUtil.getInstance().setWidth(450),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                '瘦瘦瘦',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '2019-10-6',
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 15
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: RatingBar(
                          value: 9,
                          size: 14,
                          padding: 2.5,
                          normalImage: 'assets/images/star_normal.png',
                          selectImage: 'assets/images/star.png',
                          maxRating: 10.0,
                          count: 5,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil.getInstance().setWidth(50),
                        bottom: ScreenUtil.getInstance().setHeight(80)
                    ),
                    width: ScreenUtil.getInstance().setWidth(850),
                    child: Text(
                      '拉速度快就发了可视对讲焚枯食淡明年持续，线程可视对讲里看电视是登录开发D发索拉卡代付款圣诞节螺丝刀',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil.getInstance().setWidth(25),
                vertical: ScreenUtil.getInstance().setHeight(30)
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            elevation: 10.0,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(
                            ScreenUtil.getInstance().setWidth(50)
                        ),
                        height: ScreenUtil.getInstance().setWidth(180),
                        width: ScreenUtil.getInstance().setWidth(180),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('assets/images/avatar.jpg'),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Container(
                        width: ScreenUtil.getInstance().setWidth(450),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                '瘦瘦瘦',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '2019-10-6',
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 15
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: RatingBar(
                          value: 9,
                          size: 14,
                          padding: 2.5,
                          normalImage: 'assets/images/star_normal.png',
                          selectImage: 'assets/images/star.png',
                          maxRating: 10.0,
                          count: 5,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil.getInstance().setWidth(50),
                        bottom: ScreenUtil.getInstance().setHeight(80)
                    ),
                    width: ScreenUtil.getInstance().setWidth(900),
                    child: Text(
                      '拉速度快就发了可视对讲焚枯食淡明年持续，线程可视对讲里看电视是登录开发D发索拉卡代付款圣诞节螺丝刀',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
