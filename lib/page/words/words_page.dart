import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/api/api.dart';
import 'package:flutter_bill/bean/comment_bean.dart';
import 'package:flutter_bill/component/clip/rating_bar.dart';
import 'package:flutter_bill/component/loading/loading_widget.dart';
import 'package:flutter_bill/model/words_wall_model.dart';
import 'package:flutter_bill/util/provider_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class WordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProviderUtil.wordsWallModel.getComments();
    return Consumer<WordsWallModel> (
      builder: (context, wordsWallModel, child) {
        if (wordsWallModel.commentBeanList.isEmpty) {
          return LoadingWidget(
            flag: wordsWallModel.loadingFlag,
            errorCallBack: () {
              wordsWallModel.loadingFlag = LoadingFlag.loading;
              wordsWallModel.getComments();
              wordsWallModel.refresh();
            },
          );
        } else {
          return Container(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  CommentBean commentBean = wordsWallModel.commentBeanList[index];
                  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(commentBean.createTime);
                  return Card(
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: Api.BASE_URL + "/" + commentBean.avatar,
                                    placeholder: (context, url) =>
                                        SpinKitPumpingHeart(
                                          color: Theme.of(context).primaryColor,
                                          size: 60,
                                          duration: Duration(milliseconds: 2000),
                                        ),
                                    errorWidget:
                                        (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
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
                                        commentBean.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.8,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        '${dateTime.year}-${dateTime.month}-${dateTime.day}',
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
                                  value: commentBean.rating,
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
                              '${commentBean.comment}',
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
                  );
                },
                itemCount: wordsWallModel.commentBeanList.length,
              )
          );
        }
      }
    );
  }
}
