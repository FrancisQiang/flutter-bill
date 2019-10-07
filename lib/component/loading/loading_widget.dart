import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoadingWidget extends StatelessWidget {
  final Color progressColor;
  final Color textColor;
  final double textSize;
  final String loadingText;
  final String emptyText;
  final String errorText;
  final String idleText;
  final LoadingFlag flag;
  final VoidCallback errorCallBack;
  final double size;

  LoadingWidget({
      this.progressColor,
      this.textColor,
      this.textSize,
      this.loadingText,
      this.flag = LoadingFlag.loading,
      this.errorCallBack,
      this.emptyText,
      this.errorText,
      this.size = 80.0,
      this.idleText
  });

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

    switch (flag) {
      case LoadingFlag.loading:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: size,
                width: size,
                child: SpinKitFadingCircle(
                  color: Theme.of(context).primaryColorDark,
                  duration: Duration(milliseconds: 2000),
                  size: size,
                ),
              ),
              SizedBox(
                height: size / 5,
              ),
              Text(
                loadingText ?? 'loading',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textSize ?? size / 5 ,
                  color: textColor ?? primaryColor ,
                  fontFamily: 'lobster',
                  letterSpacing: 2.0
                ),
              )
            ],
          ),
        );
        break;
      case LoadingFlag.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                  onPressed: errorCallBack ?? (){},
                  child: Text(
                    "${errorText??""}".isEmpty?'reLoadoing':errorText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: textSize ?? size / 5, color: textColor ?? primaryColor),
                  )),
            ],
          ),
        );
        break;
      case LoadingFlag.success:
        return  Builder(builder: (context) {
          Fluttertoast.showToast(
              msg: "Thank for your comment",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
          return SizedBox();
        });
        break;
      case LoadingFlag.empty:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "svgs/empty_list.svg",
                color: progressColor ?? primaryColor,
                width: size,
                height: size,
                semanticsLabel: 'empty list',
              ),
              Text(
                emptyText ?? 'loadingEmpty',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: textSize ?? size / 5, color: textColor ?? primaryColor),
              ),
            ],
          ),
        );
        break;

      case LoadingFlag.idle:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "svgs/loading_idle.svg",
                color: progressColor ?? primaryColor,
                width: size,
                height: size,
                semanticsLabel: 'idle',
              ),
              Text(
                idleText ?? 'loadingIdle',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: textSize ?? size / 5, color: textColor ?? primaryColor),
              )
            ],
          ),
        );
        break;
      default: return Container();
      break;
    }
  }
}

enum LoadingFlag { loading, error, success, empty ,idle}
