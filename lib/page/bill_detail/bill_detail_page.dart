import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/bill_bean.dart';
import 'package:flutter_bill/component/text/app_bar_text.dart';
import 'package:flutter_bill/config/my_const.dart';
import 'package:flutter_bill/model/bill_model.dart';
import 'package:flutter_bill/model/global_model.dart';
import 'package:flutter_bill/sql/bill_bean_db_helper.dart';
import 'package:flutter_bill/util/color_util.dart';
import 'package:flutter_bill/util/string_util.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BillDetailPage extends StatefulWidget {
  final BillBean billBean;

  final Icon icon;

  final String name;

  final int type;

  final bool edit;

  final String heroTag;

  final int index;

  final VoidCallback callback;

  BillDetailPage(
      {this.billBean,
      this.icon,
      this.index,
      this.name,
      this.type,
      this.edit = false,
      this.heroTag,
      this.callback});

  @override
  _BillDetailPageState createState() => _BillDetailPageState();
}

class _BillDetailPageState extends State<BillDetailPage> {
  String _money;

  String _remark;

  DateTime _dateTime;

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 如果是修改
    if (widget.billBean != null && widget.edit) {
      _money = widget.billBean.money.toString();
      _remark = widget.billBean.remark;
      _dateTime = DateTime.fromMillisecondsSinceEpoch(widget.billBean.time);
      textEditingController.text = _remark;
    } else {
      _money = '0.0';
      _remark = '';
      textEditingController.text = _remark;
      _dateTime = DateTime.now();
    }
  }

  void _saveBillBean(BillModel billModel) async {
    if (widget.edit && widget.billBean != null) {
      widget.billBean.money = double.parse(_money);
      widget.billBean.remark = _remark;
      widget.billBean.time = _dateTime.millisecondsSinceEpoch;
      billModel.billBeanList.map((item) {
        if (item.id == widget.billBean.id) {
          return widget.billBean;
        }
        return item;
      });
      billModel.refresh();
      BillBeanProvider.instance.update(widget.billBean);
      Navigator.of(context).pop();
    } else {
      BillBean billBean = BillBean(
          name: widget.name,
          type: widget.type,
          money: double.parse(_money),
          remark: _remark,
          time: _dateTime.millisecondsSinceEpoch);
      // 存入数据库
      int id = await BillBeanProvider.instance.insert(billBean);
      billBean.id = id;
      billModel.billBeanList.insert(0, billBean);
      billModel.refresh();
      Navigator.of(context).pop();
    }
  }

  Widget _getBody(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorLight.withOpacity(0.5),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              _getIconRow(context),
              _getDateRow(context),
              _getRemarkAndMoney(context),
            ],
          ),
          Positioned(
            bottom: 0,
            child: _getCalculator(context),
          )
        ],
      )
    );
  }

  Widget _getRemarkAndMoney(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(80)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(50)),
            decoration: BoxDecoration(),
            width: ScreenUtil.getInstance().setWidth(700),
            child: TextField(
              controller: textEditingController,
              style: TextStyle(
                fontFamily: 'lobster',
                fontSize: 22.0,
                letterSpacing: 3.0,
              ),
              onChanged: (value) {
                setState(() {
                  _remark = value;
                });
              },
              cursorColor: Theme.of(context).primaryColor,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Remark:',
                hintStyle: TextStyle(
                    fontFamily: 'lobster',
                    fontSize: 22.0,
                    letterSpacing: 3.0,
                    color: Theme.of(context).primaryColorDark),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Theme.of(context).primaryColorLight,
                )),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin:
                  EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(40)),
              child: Text(
                '￥ $_money',
                style: TextStyle(
                  color: Colors.red[500],
                  letterSpacing: 2.0,
                  fontFamily: 'lobster',
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Text _getCalculatorElementText(String content) {
    return Text(
      content,
      style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
    );
  }

  Widget _getCalculator(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          Container(
              width: ScreenUtil.getInstance().setWidth(810),
              height: ScreenUtil.getInstance().setHeight(1000),
              child: Wrap(
                children: <Widget>[
                  _getCommonCalculatorButton(
                    childWidget: _getCalculatorElementText('1'),
                    content: '1',
                  ),
                  _getCommonCalculatorButton(
                    childWidget: _getCalculatorElementText('2'),
                    content: '2',
                  ),
                  _getCommonCalculatorButton(
                    childWidget: _getCalculatorElementText('3'),
                    content: '3',
                  ),
                  _getCommonCalculatorButton(
                    childWidget: _getCalculatorElementText('4'),
                    content: '4',
                  ),
                  _getCommonCalculatorButton(
                    childWidget: _getCalculatorElementText('5'),
                    content: '5',
                  ),
                  _getCommonCalculatorButton(
                    childWidget: _getCalculatorElementText('6'),
                    content: '6',
                  ),
                  _getCommonCalculatorButton(
                    childWidget: _getCalculatorElementText('7'),
                    content: '7',
                  ),
                  _getCommonCalculatorButton(
                    childWidget: _getCalculatorElementText('8'),
                    content: '8',
                  ),
                  _getCommonCalculatorButton(
                    childWidget: _getCalculatorElementText('9'),
                    content: '9',
                  ),
                  _getCommonCalculatorButton(
                    childWidget: _getCalculatorElementText('0'),
                    isZero: true,
                    content: '0',
                  ),
                  _getCommonCalculatorButton(
                    childWidget: _getCalculatorElementText('.'),
                    content: '.',
                  ),
                ],
              )),
          Container(
            width: ScreenUtil.getInstance().setWidth(270),
            height: ScreenUtil.getInstance().setHeight(1000),
            child: Column(
              children: <Widget>[
                _getCommonCalculatorButton(
                    childWidget: Icon(
                      Icons.delete_forever,
                      size: 20.0,
                    ),
                    isDelete: true),
                _getCommonCalculatorButton(
                  childWidget: Text(
                    'Save',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'lobster',
                        fontWeight: FontWeight.w500),
                  ),
                  isSave: true,
                  color: Theme.of(context).primaryColor,
                  context: context,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getCommonCalculatorButton(
      {BuildContext context,
      String content,
      Widget childWidget,
      bool isZero = false,
      bool isSave = false,
      bool isDelete = false,
      Color color = Colors.white}) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil.getInstance().setWidth(10),
        vertical: ScreenUtil.getInstance().setHeight(10),
      ),
      height:
          isSave ? ScreenUtil().setHeight(720) : ScreenUtil().setHeight(240),
      width: isZero ? ScreenUtil().setWidth(520) : ScreenUtil().setWidth(250),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: Consumer<BillModel>(builder: (context, billModel, _) {
            return RaisedButton(
              color: color,
              onPressed: () {
                if (isSave) {
                  _saveBillBean(billModel);
                } else if (isDelete) {
                  if (_money.length <= 1) {
                    setState(() {
                      _money = "0.0";
                    });
                  } else {
                    setState(() {
                      _money = _money.substring(0, _money.length - 1);
                    });
                  }
                } else {
                  if (content != null) {
                    if (_money == '0.0') {
                      setState(() {
                        _money = content;
                      });
                    } else if (int.parse(_money) >= 99999) {
                      Fluttertoast.showToast(
                          msg: "Why are you so rich?",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    } else {
                      setState(() {
                        _money += content;
                      });
                    }
                  }
                }
              },
              child: childWidget,
            );
          })),
    );
  }

  Widget _getIconRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(70)),
      alignment: Alignment.center,
      height: ScreenUtil.getInstance().setHeight(200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(50)),
            child: Text(
              widget.billBean == null
                  ? StringUtil.upperCaseFirst(widget.name)
                  : StringUtil.upperCaseFirst(widget.billBean.name),
              style: TextStyle(
                  fontSize: 35.0,
                  letterSpacing: 3.5,
                  fontFamily: 'lobster',
                  color: Colors.black54),
            ),
          ),
          Consumer<BillModel>(
            builder: (context, billModel, _) {
              return Hero(
                tag: widget.heroTag == null ? "" : widget.heroTag,
                child: Container(
                    margin: EdgeInsets.only(
                        right: ScreenUtil.getInstance().setWidth(50)),
                    height: ScreenUtil.getInstance().setHeight(180),
                    width: ScreenUtil.getInstance().setHeight(180),
                    decoration: BoxDecoration(
                      color: widget.icon.color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.icon.icon,
                      color: Colors.white70,
                      size: 30.0,
                    )),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _getDateRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(70)),
      decoration: BoxDecoration(),
      alignment: Alignment.center,
      height: ScreenUtil.getInstance().setHeight(200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(50)),
            child: Text(
              '${_dateTime.year}-${_dateTime.month}-${_dateTime.day}',
              style: TextStyle(
                  fontSize: 30.0,
                  letterSpacing: 3.5,
                  fontFamily: 'lobster',
                  color: Colors.black54),
            ),
          ),
          Container(
              margin:
                  EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(50)),
              height: ScreenUtil.getInstance().setHeight(150),
              width: ScreenUtil.getInstance().setHeight(180),
              decoration: BoxDecoration(
                color: Colors.red[200],
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2000, 1, 1),
                        maxTime: DateTime(2030, 1, 1), onConfirm: (date) {
                      setState(() {
                        _dateTime = date;
                      });
                    }, currentTime: _dateTime, locale: LocaleType.zh);
                  },
                  child: Icon(
                    Icons.date_range,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: widget.type == MyConst.INCOME
              ? AppBarText('Income')
              : AppBarText('Expense'),
          centerTitle: true,
          leading: Container(
              child: FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child:
                Consumer<GlobalModel>(builder: (context, globalModel, child) {
              return Icon(
                Icons.arrow_back,
                color: ColorUtil.getWhiteOrGrey(globalModel),
              );
            }),
          )),
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 7,
              child: Consumer<BillModel>(
                builder: (context, billModel, child) {
                  return FlatButton(onPressed: () {
                    _saveBillBean(billModel);
                  }, child: Consumer<GlobalModel>(
                    builder: (context, globalModel, child) {
                      return Icon(
                        Icons.save,
                        color: ColorUtil.getWhiteOrGrey(globalModel),
                      );
                    },
                  ));
                },
              ),
            )
          ],
        ),
        resizeToAvoidBottomPadding: false,
        body: _getBody(context));
  }
}
