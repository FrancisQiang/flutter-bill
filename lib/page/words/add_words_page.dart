import 'package:flutter/material.dart';
import 'package:flutter_bill/component/clip/rating_bar.dart';
import 'package:flutter_bill/component/text/app_bar_text.dart';
import 'package:flutter_bill/model/global_model.dart';
import 'package:flutter_bill/model/home_page_model.dart';
import 'package:flutter_bill/resource/shared_preferences_keys.dart';
import 'package:flutter_bill/util/color_util.dart';
import 'package:flutter_bill/util/provider_util.dart';
import 'package:flutter_bill/util/shared_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddWordsPage extends StatefulWidget {
  @override
  _AddWordsPageState createState() => _AddWordsPageState();
}

class _AddWordsPageState extends State<AddWordsPage> {

  String _ratingValue;

  TextEditingController _commentsController;
  TextEditingController _contactController;

  @override
  void initState() {
    super.initState();
    _ratingValue = "10";
    _commentsController = TextEditingController();
    _contactController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: AppBarText(
          'Leave Message',
        ),
        actions: <Widget>[
          Consumer2<GlobalModel, HomePageModel>(
            builder: (context, globalModel, homePageModel, child) {
              return IconButton(
                icon: Icon(
                  Icons.check,
                  size: 30,
                  color: ColorUtil.getWhiteOrGrey(globalModel),
                ),
                onPressed: () async {
                  debugPrint("===========================>" + _ratingValue);
                  debugPrint("===========================>" + _commentsController.text);
                  debugPrint("===========================>" + _contactController.text);
                  debugPrint("=========================>" + await SharedUtil.instance.getString(SharedPreferencesKeys.LOCAL_AVATAR_PATH));
                  debugPrint("=========================>" + homePageModel.currentUserName);
                },
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil.getInstance().setHeight(250)
              ),
              padding: EdgeInsets.all(5),
              width: ScreenUtil.getInstance().setWidth(850),
              height: ScreenUtil.getInstance().setHeight(800),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 4.5,
                ),
              ),
              child: Form(
                autovalidate: true,
                child: Theme(
                  data: ThemeData(platform: TargetPlatform.android),
                  child: TextFormField(
                    controller: _commentsController,
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                        hintText: 'Write down your comments here!',
                        hintStyle: TextStyle(color: Colors.grey)),
                    maxLength: 2000,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(5),
              height: ScreenUtil.getInstance().setHeight(200),
              width: ScreenUtil.getInstance().setWidth(850),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 4,
                ),
              ),
              child: Form(
                autovalidate: true,
                child: Theme(
                  data: ThemeData(platform: TargetPlatform.android),
                  child: TextFormField(
                    controller: _contactController,
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      border: InputBorder.none,
                      hintText: 'You can also leave your contact way',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil.getInstance().setWidth(180),
                        top: ScreenUtil.getInstance().setHeight(30)
                    ),
                    width: ScreenUtil.getInstance().setWidth(620),
                    height: ScreenUtil.getInstance().setHeight(120),
                    child: RatingBar(
                      isDynamic: true,
                      value: 10,
                      size: 35,
                      padding: 5,
                      normalImage: 'assets/images/star_normal.png',
                      selectImage: 'assets/images/star.png',
                      selectAble: true,
                      onRatingUpdate: (value) {
                        setState(() {
                          _ratingValue = value;
                        });
                      },
                      maxRating: 10,
                      count: 5,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: ScreenUtil.getInstance().setHeight(120),
                    margin: EdgeInsets.only(
                      left: ScreenUtil.getInstance().setWidth(15),
                      right: ScreenUtil.getInstance().setWidth(15),
                        top: ScreenUtil.getInstance().setHeight(30),
                    ),
                    child: Text(
                      '$_ratingValue',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
