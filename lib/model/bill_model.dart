import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/bill_bean.dart';
import 'package:flutter_bill/bean/income_expense_bean.dart';
import 'package:flutter_bill/config/my_const.dart';
import 'package:flutter_bill/resource/shared_preferences_keys.dart';
import 'package:flutter_bill/sql/bill_bean_db_helper.dart';
import 'package:flutter_bill/util/shared_util.dart';

class BillModel with ChangeNotifier {

  // 账单的列表
  List<BillBean> _billBeanList = [];

  List<BillBean> get billBeanList => this._billBeanList;

  double _currentMonthBudget;

  double get currentMonthBudget => this._currentMonthBudget;

  set currentMonthBudget(double value) {
    _currentMonthBudget = value;
  }

  double _currentExpense;

  double get currentExpense => this._currentExpense;

  set currentExpense(double value) {
    _currentExpense = value;
  }

  Future<Null> storageBudget() async {
    await SharedUtil.instance.saveDouble(SharedPreferencesKeys.MONTH_BUDGET, this._currentMonthBudget);
  }

  Future<Null> getBudget() async {
    double budget = await SharedUtil.instance.getDouble(SharedPreferencesKeys.MONTH_BUDGET);
    if (budget != null) {
      _currentMonthBudget = budget;
    }
  }


  // 首先从缓存中获取billBeanList，如果为空则返回全局的
  Future<List<BillBean>> getBillBeanList() async {
    List<BillBean> list = await BillBeanProvider.instance.getAll();
    if (list != null) {
      _billBeanList.clear();
      _billBeanList.addAll(list);
    }
    return _billBeanList;
  }

  Future<IncomeExpenseBean> getMonthIncomeAndExpense() async {
    IncomeExpenseBean incomeExpenseBean;
    await getBillBeanList();
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

  refresh() {
    notifyListeners();
  }

}