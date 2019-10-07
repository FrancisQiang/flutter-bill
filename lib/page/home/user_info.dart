import 'package:flutter/material.dart';
import 'package:flutter_bill/model/home_page_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(280),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Consumer<HomePageModel>(
            builder: (BuildContext context, HomePageModel homePageModel, child) {
              return GestureDetector(
                onTap: () {
                  homePageModel.onUserNameTap(context: context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(50)),
                  width: ScreenUtil.getInstance().setWidth(800),
                  child: FutureBuilder<String>(
                    future: homePageModel.getCurrentUserName(),
                    builder: (context, snapshot) {
                      return Text(
                        'Hello! ${snapshot.data}',
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 2.8,
                            fontFamily: 'lobster'
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      );
                    },
                  )
                ),
              );
            },
          ),
          Consumer<HomePageModel>(
            builder: (BuildContext context, HomePageModel homePageModel, child) {
              return Container(
                margin: EdgeInsets.only(
                  left: ScreenUtil.getInstance().setWidth(10),
                  right: ScreenUtil.getInstance().setWidth(40),),
                height: ScreenUtil.getInstance().setWidth(180),
                width: ScreenUtil.getInstance().setWidth(180),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: homePageModel.getAvatarWidget(),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(100.0))
                ),
              );
            },
          )
        ],
      ),
    );
  }
}