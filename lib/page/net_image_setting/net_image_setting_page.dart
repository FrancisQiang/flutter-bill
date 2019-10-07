import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/photo_bean.dart';
import 'package:flutter_bill/component/loading/loading_widget.dart';
import 'package:flutter_bill/component/text/app_bar_text.dart';
import 'package:flutter_bill/model/global_model.dart';
import 'package:flutter_bill/page/image_page/image_page.dart';
import 'package:flutter_bill/resource/shared_preferences_keys.dart';
import 'package:flutter_bill/util/api_method_util.dart';
import 'package:flutter_bill/util/shared_util.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class NetImageSettingPage extends StatefulWidget {
  @override
  _NetImageSettingPageState createState() => _NetImageSettingPageState();
}

class _NetImageSettingPageState extends State<NetImageSettingPage> {
  List<PhotoBean> photoBeanList = [];
  LoadingFlag loadingFlag = LoadingFlag.loading;
  CancelToken cancelToken;

  @override
  void initState() {
    super.initState();
    cancelToken = CancelToken();
    getPhotos(cancelToken: cancelToken,);
  }

  @override
  Widget build(BuildContext context) {
    EasyRefreshController _easyRefreshController = EasyRefreshController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppBarText(
          'Net Image'
        )
      ),
      body: loadingFlag == LoadingFlag.success || photoBeanList.isNotEmpty ?
      Container(
          child: EasyRefresh(
            controller: _easyRefreshController,
            footer: BezierBounceFooter(
                backgroundColor: Theme.of(context).primaryColorDark
            ),
            onLoad: () async {
              loadMorePhoto();
            },
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(photoBeanList.length, (index) {
                final url = photoBeanList[index].urls.regular;
                final urls = photoBeanList.map((photoBean) => photoBean.urls.small).toList();
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(new CupertinoPageRoute(builder: (ctx) {
                      return Consumer<GlobalModel>(
                        builder: (context, globalModel, _) {
                          return ImagePage(
                            imageUrls: urls,
                            initialPageIndex: index,
                            onSelect: (current) async {
                              final currentUrl = photoBeanList[current].urls.small;
                              SharedUtil.instance.saveString(
                                  SharedPreferencesKeys.CURRENT_NET_PICTURE_URL, currentUrl);
                              SharedUtil.instance.saveBoolean(
                                  SharedPreferencesKeys.IS_DAILY, false);
                              globalModel.currentNetPicUrl = currentUrl;
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      child: Hero(
                        tag: "tag_$index",
                        child: CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => new Container(
                            alignment: Alignment.center,
                            child: SpinKitPumpingHeart(
                              color: Theme.of(context).primaryColor,
                              size: 60,
                              duration: Duration(milliseconds: 2000),
                            ),
                          ),
                          errorWidget: (context, url, error) => new Icon(
                            Icons.error,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
      ) : LoadingWidget(
        errorText: "Touch to reload",
        flag: loadingFlag,
        errorCallBack: () {
          setState(() {
            loadingFlag = LoadingFlag.loading;
          });
          getPhotos();
        },
      )
    );
  }

  void loadMorePhoto() {
    getPhotos(
      page: photoBeanList.length ~/ 20 + 1,
      cancelToken: cancelToken,
    );
  }

  void getPhotos({
    int page = 1,
    int perPage = 20,
    CancelToken cancelToken,
  }) {
    ApiMethodUtil.instance.getPhotos(
      success: (beans) {
        List<PhotoBean> photoBeans = beans;
        if (photoBeans.length == 0) {
          loadingFlag = LoadingFlag.empty;
        } else {
          loadingFlag = LoadingFlag.success;
          photoBeanList.addAll(photoBeans);
        }
        refresh();
      },
      failed: (fail) {
        loadingFlag = LoadingFlag.error;
        refresh();
      },
      error: (error) {
        debugPrint("错误:$error");
        loadingFlag = LoadingFlag.error;
        refresh();
      },
      params: {
        "client_id": "55fd58111fc98b81349a7c24036c8e69abdaba4d693bbfea981d29bfb7ccdd53",
        "page": "$page",
        "per_page": "$perPage"
      },
    );
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

}

