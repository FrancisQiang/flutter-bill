import 'package:flutter/material.dart';
import 'package:flutter_bill/component/clip/rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil.getInstance().setWidth(25)
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            elevation: 10.0,
            child: Container(
              child: Column(
                children: <Widget>[
                  Row(
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
                        width: ScreenUtil.getInstance().setWidth(500),
                        child: Column(
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
                          size: 20,
                          padding: 2.5,
                          normalImage: 'images/star_normal.png',
                          selectImage: 'images/star.png',
                          maxRating: 10.0,
                          count: 5,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
