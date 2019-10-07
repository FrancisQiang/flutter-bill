import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/component/loading/loading_widget.dart';
import 'package:flutter_bill/config/my_const.dart';
import 'package:flutter_bill/model/global_model.dart';
import 'package:flutter_bill/page/image_page/image_page.dart';
import 'package:flutter_bill/page/image_setting/image_setting_page.dart';
import 'package:flutter_bill/util/navigator_util.dart';
import 'package:flutter_bill/util/provider_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  Widget _getDrawerHeaderWidget(GlobalModel globalModel, BuildContext context) {
    return FutureBuilder<bool>(
        future: globalModel.getIsDaily(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return LoadingWidget();
            case ConnectionState.waiting:
              return LoadingWidget();
            default:
              if (snapshot.hasError) {
                return new Text('Error: ${snapshot.error}');
              } else {
                return FutureBuilder<String>(
                    future: globalModel.getCurrentNetPicUrlFromCache(),
                    builder: (BuildContext buildContext,
                        AsyncSnapshot<String> snapshotString) {
                      if (snapshotString.hasData) {
                        return GestureDetector(
                            onTap: () {
                            Navigator.push(
                                context, CupertinoPageRoute(builder: (ctx) {
                              return ImagePage(
                                imageUrls: [globalModel.isDaily ? MyConst.DAILY_PIC_URL : snapshotString.data],
                              );
                            }));
                            },
                            child: Hero(
                                tag: "tag_0",
                                child: Container(
                                    height:
                                        ScreenUtil.getInstance().setHeight(585),
                                    child: snapshot.data
                                        ? Image.network(
                                            MyConst.DAILY_PIC_URL,
                                            fit: BoxFit.cover,
                                          )
                                        : CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: snapshotString.data,
                                            placeholder: (context, url) =>
                                                SpinKitPumpingHeart(
                                                  color: Theme.of(context).primaryColor,
                                                  size: 60,
                                                  duration: Duration(milliseconds: 2000),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ))));
                      } else {
                        return Container();
                      }
                    });
              }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalModel>(
      builder: (context, globalModel, _) {
        return ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            _getDrawerHeaderWidget(globalModel, context),
            ListTile(
              title: Text(
                'Picture',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w100,
                    letterSpacing: 2.5,
                    fontFamily: 'lobster'),
              ),
              leading: Icon(
                Icons.photo,
                size: 28.0,
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 28.0,
              ),
              onTap: () {
                Navigator.push(context, new CupertinoPageRoute(builder: (ctx) {
                  return ProviderUtil.getGlobalModel(child: ImageSettingPage());
                }));
              },
            ),
            ListTile(
              title: Text(
                'Theme',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w100,
                    letterSpacing: 2.5,
                    fontFamily: 'lobster'),
              ),
              leading: Icon(
                Icons.color_lens,
                size: 28.0,
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 28.0,
              ),
              onTap: () {
                NavigatorUtil.toThemePage(context);
              },
            ),
            ListTile(
              title: Text(
                'User',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w100,
                    letterSpacing: 2.5,
                    fontFamily: 'lobster'),
              ),
              leading: Icon(
                Icons.person,
                size: 28.0,
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 28.0,
              ),
              onTap: () {
                NavigatorUtil.toUserPage(context);
              },
            ),
          ],
        );
      },
    );
  }
}
