import 'package:flutter/material.dart';
import 'package:flutter_bill/page/home/user_info.dart';
import 'package:flutter_bill/util/provider_util.dart';
import 'bill_total_and_list.dart';

class HomeBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          UserInfo(),
          Expanded(child: ProviderUtil.getBillModelPage(BillTotalAndList()))
        ],
      ),
    );
  }

}