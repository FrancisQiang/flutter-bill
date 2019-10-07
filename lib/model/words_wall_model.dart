import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/comment_bean.dart';
import 'package:flutter_bill/component/loading/loading_widget.dart';
import 'package:flutter_bill/util/api_method_util.dart';

class WordsWallModel with ChangeNotifier {

  CancelToken _cancelToken = CancelToken();

  List<CommentBean> _commentBeanList = [];

  LoadingFlag _loadingFlag = LoadingFlag.loading;


  CancelToken get cancelToken => this._cancelToken;

  set cancelToken(CancelToken value) {
    _cancelToken = value;
  }

  List<CommentBean> get commentBeanList => this._commentBeanList;

  set commentBeanList(List<CommentBean> value) {
    _commentBeanList = value;
  }

  LoadingFlag get loadingFlag => this._loadingFlag;

  set loadingFlag(LoadingFlag value) {
    _loadingFlag = value;
  }

  void getComments(){
    ApiMethodUtil.instance.getComments(
      success: (data){
        CommentListBean commentListBean = CommentListBean.fromJson(data);
        _commentBeanList.clear();
        _commentBeanList.addAll(commentListBean.data);
        ///反转列表，按照时间最新的排在最前面
        _commentBeanList = _commentBeanList.reversed.toList();
        if(_commentBeanList.isEmpty){
          _loadingFlag = LoadingFlag.empty;
        }
        refresh();
      }, error: (msg){
      _loadingFlag = LoadingFlag.error;
      refresh();
    },
      token: _cancelToken,
    );
  }

  void refresh(){
    notifyListeners();
  }

}