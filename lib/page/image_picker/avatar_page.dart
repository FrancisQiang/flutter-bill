import 'package:flutter/material.dart';
import 'package:flutter_bill/component/text/app_bar_text.dart';
import 'package:flutter_bill/config/my_const.dart';
import 'package:flutter_bill/model/global_model.dart';
import 'package:flutter_bill/model/home_page_model.dart';
import 'package:flutter_bill/util/color_util.dart';
import 'package:image_crop/image_crop.dart';
import 'package:provider/provider.dart';

class AvatarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomePageModel, GlobalModel>(
      builder: (context, homePageModel, globalModel, child) {
        return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: AppBarText('Avatar Setting'),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.check,
                      color: ColorUtil.getWhiteOrGrey(globalModel),
                      size: 25,
                    ),
                    onPressed: () {
                      homePageModel.onSaveTap();
                      Navigator.of(context).pop();
                    }
                )
              ],
            ),
            body: Container(
              alignment: Alignment.center,
              child: Hero(
                tag: MyConst.AVATAR_HERO_TAG,
                child: Crop(
                  key: homePageModel.cropKey,
                  image: homePageModel.getAvatarProvider(),
                  aspectRatio: 1.0,
                  maximumScale: 1.0,
                ),
              ),
            )
        );
      },
    );
  }
}
