import 'package:flutter/material.dart';
import 'package:flutter_bill/component/clip/italic_clip.dart';
import 'package:flutter_bill/config/my_const.dart';
import 'package:flutter_bill/model/home_page_model.dart';
import 'package:flutter_bill/util/color_util.dart';
import 'package:flutter_bill/util/navigator_util.dart';
import 'package:flutter_bill/util/permission_request_util.dart';
import 'package:flutter_bill/util/provider_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UserPageTop extends StatelessWidget {

  Widget _getBottomSheetButton(
      {@required String content,
        @required BuildContext context,
        Function function}) {
    return InkWell(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil.getInstance().setWidth(1080),
        height: ScreenUtil.getInstance().setHeight(200),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
        child: Text(
          content,
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 22,
              letterSpacing: 0.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: ItalicClipper(),
            child: Container(
              height: ScreenUtil.getInstance().setHeight(700),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColorDark,
                    ColorUtil.getDark(Theme.of(context).primaryColorDark),
                    ColorUtil.getDark(Theme.of(context).primaryColorDark,
                        level: 40),
                    ColorUtil.getDark(Theme.of(context).primaryColorDark,
                        level: 50),
                  ])),
            ),
          ),
          Positioned(
            left: ScreenUtil.getInstance().setWidth(20),
            top: ScreenUtil.getInstance().setHeight(100),
            child: Container(
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.arrow_back,
                    color: ColorUtil.getWhiteOrGrey(ProviderUtil.getGlobal()),
                    size: 30,
                  ),
                )),
          ),
          Positioned(
            left: ScreenUtil.getInstance().setWidth(450),
            top: ScreenUtil.getInstance().setHeight(30),
            child: Container(
              child: Text(
                'User',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'lobster',
                    letterSpacing: 3.3),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          Consumer<HomePageModel>(
            builder: (context, homePageModel, child) {
              return Positioned(
                left: ScreenUtil.getInstance().setWidth(80),
                bottom: ScreenUtil.getInstance().setHeight(150),
                child: Container(
                  child: Text(
                    homePageModel.currentUserName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'lobster',
                        letterSpacing: 3.3),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              );
            },
          ),
          Consumer<HomePageModel>(
            builder: (context, homePageModel, child) {
              return Positioned(
                  right: ScreenUtil.getInstance().setWidth(50),
                  top: ScreenUtil.getInstance().setHeight(350),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            width: ScreenUtil.getInstance().setWidth(1080),
                            height: ScreenUtil.getInstance().setHeight(400),
                            child: Column(
                              children: <Widget>[
                                _getBottomSheetButton(
                                  content: 'Change From Album',
                                  function: () {
                                    PermissionReqUtil.getInstance()
                                        .requestPermission(
                                      PermissionGroup.photos,
                                      granted: homePageModel.getImage,
                                      deniedDes: 'Deny',
                                      context: context,
                                      openSetting: 'Allow',
                                    );
                                  },
                                  context: context,
                                ),
                                _getBottomSheetButton(
                                  content: 'Just Edit Now',
                                  function: () {
                                    Navigator.pop(context);
                                    NavigatorUtil.toAvatarPage(context);
                                  },
                                  context: context,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Hero(
                      tag: MyConst.AVATAR_HERO_TAG,
                      child: Container(
                        height: ScreenUtil.getInstance().setWidth(300),
                        width: ScreenUtil.getInstance().setWidth(300),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: homePageModel.getAvatarWidget(),
                          ),
                          border: Border.all(
                              color: Colors.grey[200], width: 3.3),
                        ),
                      ),
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
