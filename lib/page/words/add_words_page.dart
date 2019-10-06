import 'package:flutter/material.dart';
import 'package:flutter_bill/component/text/app_bar_text.dart';
import 'package:flutter_bill/model/global_model.dart';
import 'package:flutter_bill/util/color_util.dart';
import 'package:provider/provider.dart';

class AddWordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppBarText(
          'Leave Message',
        ),
        actions: <Widget>[
          Consumer<GlobalModel>(
            builder: (context, globalModel, child) {
              return IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: ColorUtil.getWhiteOrGrey(globalModel),
                ),
                onPressed: () {},
              );
            },
          )
        ],
      ),
    );
  }
}
