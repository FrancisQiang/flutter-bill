import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'loading_widget.dart';

class NetLoadingWidget extends StatefulWidget {
  final LoadingController loadingController;
  final Widget successWidget;
  final String loadingText;
  final String errorText;
  final String successText;
  final String emptyText;
  final String idleText;
  final VoidCallback onRequest;
  final VoidCallback onSuccess;
  final CancelToken cancelToken;

  const NetLoadingWidget({
    Key key,
    this.loadingController,
    this.successWidget, this.loadingText, this.errorText, this.successText, this.emptyText, this.idleText, this.onRequest, this.cancelToken, this.onSuccess,
  }) : super(key: key);

  @override
  _NetLoadingWidgetState createState() => _NetLoadingWidgetState();
}

class _NetLoadingWidgetState extends State<NetLoadingWidget> {
  LoadingFlag loadingFlag = LoadingFlag.loading;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.3),
        body: Container(
          width: size.width,
          height: size.height,
          alignment: Alignment.center,
          child: Container(
            width: size.width / 4 * 3,
            height: size.height / 2.5,
            child: LoadingWidget(
              flag: loadingFlag,
              loadingText: getLoadingText(),
              errorCallBack: widget.onRequest ?? (){},
              errorText: getLoadingText(),
            ),
          ),
        ),
      ),
    );
  }



  @override
  void initState() {
    super.initState();
    widget?.loadingController?._setState(this);
    if(widget.onRequest != null){
      widget.onRequest();
    }
  }


  @override
  void dispose() {
    widget?.cancelToken?.cancel();
    super.dispose();
  }

  String getLoadingText() {
    switch (loadingFlag) {
      case LoadingFlag.loading:
        return widget.loadingText ?? "loading";
        break;
      case LoadingFlag.error:
        return widget.errorText ?? "error";
        break;
      case LoadingFlag.success:
        return widget.successText ?? "success";
        break;
      case LoadingFlag.empty:
        return widget.emptyText ??  "";
        break;
      case LoadingFlag.idle:
        return widget.idleText ?? "";
        break;
    }
    return widget.loadingText ?? "loading";
  }
}

class LoadingController {
  _NetLoadingWidgetState _state;
  LoadingFlag _flag = LoadingFlag.loading;

  void setFlag(LoadingFlag loadingFlag) {
    _state?.loadingFlag = loadingFlag;
    _flag = loadingFlag;
    if (_state?.mounted ?? false) {
      _state?.setState(() {});
    }
    print("设置:${_state?.loadingFlag}");
  }

  void _setState(_NetLoadingWidgetState state) {
    if (this?._state == null) {
      this?._state = state;
    } else {
      this._state = null;
      this._state = state;
    }
    print("设置了:${this._state}");
  }

  LoadingFlag get flag => _flag;


}
