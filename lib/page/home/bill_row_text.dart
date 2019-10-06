import 'package:flutter/material.dart';

class BillRowText extends StatelessWidget {
  final Widget topChild;
  final Widget bottomChild;

  BillRowText({this.topChild, this.bottomChild});

  @override
  Widget build(BuildContext context) {
    double margin = (MediaQuery.of(context).size.height - 112.0) / 40;
    return Container(
      child: Column(
        children: <Widget>[
          topChild,
          Container(
            margin: EdgeInsets.only(top: margin),
            child: bottomChild,
          )
        ],
      ),
    );
  }
}