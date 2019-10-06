import 'package:flutter/material.dart';

class ShowFullScreenDialogUtil{

  static void showDialog({@required BuildContext context,@required Widget child}){
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (ctx,anm1,anm2){
          return child;
        }
    ));
  }
}

