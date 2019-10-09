import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/bill_bean.dart';
import 'package:flutter_bill/bean/income_expense_bean.dart';
import 'package:flutter_bill/component/loading/loading_widget.dart';
import 'package:flutter_bill/config/my_const.dart';
import 'package:flutter_bill/model/bill_model.dart';
import 'package:flutter_bill/sql/bill_bean_db_helper.dart';
import 'package:flutter_bill/util/provider_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'bill_bean_item.dart';
import 'bill_row_text.dart';

class BillTotalAndList extends StatefulWidget {
  @override
  _BillTotalAndListState createState() => _BillTotalAndListState();
}

class _BillTotalAndListState extends State<BillTotalAndList> {

  final TextStyle billRowTextStyle = TextStyle(
      color: Colors.white,
      letterSpacing: 2.2,
      fontFamily: 'lobster',
      fontWeight: FontWeight.w500,
      fontSize: 18.0);

  IncomeExpenseBean incomeExpenseBean;

  List<BillBean> _billBeanList;

  // icon代数和icon名称的映射
  Map<String, int> _iconDataMap;

  Future<Map<String, int>> _getIconMap() async {
    _iconDataMap = await ProviderUtil.iconSettingModel.getIconMapFromDisk();
    return _iconDataMap;
  }

  @override
  void initState() {
    _initBillList();
    _getIconMap();
    super.initState();
  }


  Widget _getMonthBill() {
    if (_billBeanList == null) {
      return FutureBuilder<IncomeExpenseBean>(
        future: ProviderUtil.getBillModel().getMonthIncomeAndExpense(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return SizedBox();
            case ConnectionState.waiting:
              return SizedBox();
            default:
              if (snapshot.hasError)
                return Icon(Icons.error);
              else {
                return Builder(
                  builder: (context) {
                    double income = snapshot.data.income;
                    double expense = snapshot.data.expense;
                    return Container(
                      height: ScreenUtil.getInstance().setHeight(170),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          BillRowText(
                            width: 150,
                            topChild: Text('${DateTime
                                .now()
                                .year}',
                                style: billRowTextStyle),
                            bottomChild: Text(
                              '${DateTime
                                  .now()
                                  .month}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          BillRowText(
                            topChild: Text(
                              'income',
                              style: billRowTextStyle,
                            ),
                            bottomChild: Text('${income.toStringAsFixed(2)}',
                                overflow: TextOverflow.ellipsis,
                                style: billRowTextStyle),
                          ),
                          BillRowText(
                            topChild: Text(
                              'expense',
                              style: billRowTextStyle,
                            ),
                            bottomChild: Text('${expense.toStringAsFixed(2)}',
                                overflow: TextOverflow.ellipsis,
                                style: billRowTextStyle),
                          ),
                          BillRowText(
                            topChild: Text(
                              'total',
                              style: billRowTextStyle,
                            ),
                            bottomChild: Text(
                                '${(income - expense).toStringAsFixed(2)}',
                                overflow: TextOverflow.ellipsis,
                                style: billRowTextStyle),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
          }
        },
      );
    } else {
      return Container(
        height: ScreenUtil.getInstance().setHeight(170),
        child: Consumer<BillModel>(
          builder: (context, billModel, child) {
            incomeExpenseBean = calculateMonthIncomeAndExpense(billModel.billBeanList);
            double income = incomeExpenseBean.income;
            double expense = incomeExpenseBean.expense;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                BillRowText(
                  width: 150,
                  topChild: Text('${DateTime
                      .now()
                      .year}',
                      style: billRowTextStyle),
                  bottomChild: Text(
                    '${DateTime
                        .now()
                        .month}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                BillRowText(
                  topChild: Text(
                    'income',
                    style: billRowTextStyle,
                  ),
                  bottomChild: Text('${income.toStringAsFixed(2)}',
                      style: billRowTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                BillRowText(
                  topChild: Text(
                    'expense',
                    style: billRowTextStyle,
                  ),
                  bottomChild: Text('${expense.toStringAsFixed(2)}',
                      style: billRowTextStyle),
                ),
                BillRowText(
                  topChild: Text(
                    'total',
                    style: billRowTextStyle,
                  ),
                  bottomChild: Text(
                      '${(income - expense).toStringAsFixed(2)}',
                      overflow: TextOverflow.ellipsis,
                      style: billRowTextStyle),
                ),
              ],
            );
          },
        ),
      );
    }
  }

  Future<IncomeExpenseBean> _initBillList() async {
    _billBeanList = await ProviderUtil.getBillModel().getBillBeanList();
    double income = 0;
    double expense = 0;
    var now = DateTime.now();
    int year = now.year;
    int month = now.month;
    _billBeanList.forEach((item) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(item.time);
      if (dateTime.year == year && dateTime.month == month) {
        if (item.type == MyConst.INCOME) {
          income += item.money;
        } else if (item.type == MyConst.EXPEND) {
          expense += item.money;
        }
      }
    });
    incomeExpenseBean = IncomeExpenseBean(income: income, expense: expense);
    return incomeExpenseBean;
  }

  IncomeExpenseBean calculateMonthIncomeAndExpense(List<BillBean> billBeanList) {
    double income = 0;
    double expense = 0;
    var now = DateTime.now();
    int year = now.year;
    int month = now.month;
    billBeanList.forEach((item) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(item.time);
      if (dateTime.year == year && dateTime.month == month) {
        if (item.type == MyConst.INCOME) {
          income += item.money;
        } else if (item.type == MyConst.EXPEND) {
          expense += item.money;
        }
      }
    });
    incomeExpenseBean = IncomeExpenseBean(income: income, expense: expense);
    return incomeExpenseBean;
  }

  // 删除item
  void _remove(int index) {
    BillBean billBean;
    setState(() {
      billBean = _billBeanList.removeAt(index);
      incomeExpenseBean = calculateMonthIncomeAndExpense(_billBeanList);
    });
    Fluttertoast.showToast(
        msg: "delete success",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
    BillBeanProvider.instance.delete(billBean.id);
  }

  Widget _getBillList() {
    if (_billBeanList == null) {
      return Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Consumer<BillModel>(
            builder: (context, billModel, child) {
              return FutureBuilder<List<BillBean>>(
                future: billModel.getBillBeanList(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return LoadingWidget();
                    case ConnectionState.waiting:
                      return LoadingWidget();
                    default:
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      else {
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BillBeanItem(
                              item: snapshot.data[index],
                              index: index,
                              remove: _remove,
                              iconColor: MyConst.iconColorList[index % 10],
                              iconAlgebra:
                              _iconDataMap[snapshot.data[index].name],
                            );
                          },
                          itemExtent: ScreenUtil.getInstance().setHeight(300),
                          itemCount: snapshot.data.length,
                        );
                      }
                  }
                },
              );
            },
          ));
    } else {
      return Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Consumer<BillModel>(
            builder: (context, billModel, child) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return BillBeanItem(
                    item: billModel.billBeanList[index],
                    index: index,
                    remove: _remove,
                    iconColor: MyConst.iconColorList[index % 10],
                    iconAlgebra:
                    _iconDataMap[billModel.billBeanList[index].name],
                  );
                },
                itemExtent: ScreenUtil.getInstance().setHeight(300),
                itemCount: billModel.billBeanList.length,
              );
            },
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _getMonthBill(),
        Expanded(child: _getBillList())
      ],
    );
  }
}
