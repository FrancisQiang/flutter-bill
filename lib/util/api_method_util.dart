import 'package:flutter_bill/api/api.dart';
import 'package:flutter_bill/bean/photo_bean.dart';
import 'package:flutter_bill/bean/response_bean.dart';
import 'dio_util.dart';
export 'package:dio/dio.dart';

class ApiMethodUtil {
  factory ApiMethodUtil() => _getInstance();

  static ApiMethodUtil get instance => _getInstance();
  static ApiMethodUtil _instance;

  static const int SUCCEED = 0;
  static const int FAILED = 1;

  ApiMethodUtil._internal();

  static ApiMethodUtil _getInstance() {
    if (_instance == null) {
      _instance = ApiMethodUtil._internal();
    }
    return _instance;
  }

  ///获取图片
  void getPhotos({
    Function success,
    Function failed,
    Function error,
    Map<String, String> params,
    CancelToken token,
  }) {
    DioUtil.getInstance().get(
      Api.PHOTO_URL,
      (data) {
        if (data.toString().contains("errors")) {
          failed(data);
        } else {
          List<PhotoBean> photoBeanList = PhotoBean.fromMapList(data);
          success(photoBeanList);
        }
      },
      params: params,
      errorCallBack: (errorMessage) {
        error(errorMessage);
      },
      token: token,
    );
  }

  /// 上传评论意见
  void postComment(
      {FormData params,
        Function success,
        Function failed,
        Function error,
        CancelToken token}) {
    DioUtil.getInstance().postUpload(
        Api.BASE_URL + "/comment", (data) {
      ResponseBean responseBean = ResponseBean.fromJson(data);
      if (responseBean.code == 0) {
        success(responseBean);
      } else {
        failed(responseBean);
      }
    }, (count, total) {},
        formData: params, errorCallBack: (errorMessage) {
      error(errorMessage);
    });
  }

  /// 获取所有评论个信息
  void getComments({
    Function success,
    Function error,
    CancelToken token,
  }) {
    DioUtil.getInstance().get(
      Api.BASE_URL + "/comment",
          (data) {
        success(data);
      },
      errorCallBack: (errorMessage) {
        error(errorMessage);
      },
      token: token,
    );
  }

}
