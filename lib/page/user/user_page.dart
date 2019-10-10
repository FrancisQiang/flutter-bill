import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/component/clip/italic_clip.dart';
import 'package:flutter_bill/component/progress/circular_progress.dart';
import 'package:flutter_bill/config/my_const.dart';
import 'package:flutter_bill/model/bill_model.dart';
import 'package:flutter_bill/model/home_page_model.dart';
import 'package:flutter_bill/page/user/user_page_icon.dart';
import 'package:flutter_bill/page/user/user_page_top.dart';
import 'package:flutter_bill/util/color_util.dart';
import 'package:flutter_bill/util/navigator_util.dart';
import 'package:flutter_bill/util/permission_request_util.dart';
import 'package:flutter_bill/util/provider_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation animation;
  double scale;
  TextEditingController budgetController;

  @override
  initState() {
    super.initState();
    if (ProviderUtil.getBillModel().currentMonthBudget != null) {
      scale = (ProviderUtil.getBillModel().currentExpense /
          ProviderUtil.getBillModel().currentMonthBudget);
      if (scale.isNegative) {
        scale = 0.0;
      }
    } else {
      scale = 0.0;
    }
    controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));
    controller.forward(from: 0.0);
    animation = Tween(begin: 0.0, end: 360 * scale).animate(controller);

    controller.addListener(() {
      setState(() {});
    });
    budgetController = TextEditingController();
  }

  TextStyle _getTextStyleByBudget(double budget) {
    return budget == null
        ? TextStyle(
            color: Colors.grey.withOpacity(0.8),
            fontSize: 16,
            fontFamily: 'lobster')
        : TextStyle(color: Colors.black87, fontSize: 17, fontFamily: 'lobster');
  }

  _setBudget(BuildContext context, BillModel billModel) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Container(
                height: ScreenUtil.getInstance().setHeight(700),
                width: ScreenUtil.getInstance().setWidth(900),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().setHeight(50)),
                      child: Text(
                        'Set your budget',
                        style: TextStyle(
                            fontFamily: 'lobster',
                            letterSpacing: 2.0,
                            fontSize: 25),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().setHeight(120)),
                      height: ScreenUtil.getInstance().setHeight(200),
                      width: ScreenUtil.getInstance().setWidth(600),
                      child: TextField(
                        autofocus: true,
                        controller: budgetController,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          hintText: 'input budget amount',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().setHeight(40)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: FlatButton(
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                          Expanded(
                            child: FlatButton(
                              child: Text(
                                'Yes',
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                billModel.currentMonthBudget =
                                    double.parse(budgetController.text);
                                billModel.refresh();
                                billModel.storageBudget();
                                Navigator.pop(context);
                                setState(() {
                                  scale = (ProviderUtil.getBillModel()
                                          .currentExpense /
                                      ProviderUtil.getBillModel()
                                          .currentMonthBudget);
                                  if (scale.isNegative) {
                                    scale = 0.0;
                                  }
                                  controller.forward(from: 0.0);
                                  animation =
                                      Tween(begin: 0.0, end: 360 * scale)
                                          .animate(controller);
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          UserPageTop(),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().setHeight(100),
              left: ScreenUtil.getInstance().setWidth(40),
              right: ScreenUtil.getInstance().setWidth(40),
            ),
            height: ScreenUtil.getInstance().setHeight(300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                UserPageIcon(
                  iconData: FontAwesomeIcons.github,
                  color: Colors.indigoAccent,
                  size: 34,
                  name: 'github',
                ),
                UserPageIcon(
                  iconData: FontAwesomeIcons.java,
                  color: Colors.pink,
                  size: 34,
                  name: 'java',
                ),
                UserPageIcon(
                  iconData: FontAwesomeIcons.angular,
                  color: Colors.deepOrange,
                  size: 34,
                  name: 'angular',
                ),
                UserPageIcon(
                  iconData: FontAwesomeIcons.vuejs,
                  color: Colors.green,
                  size: 34,
                  name: 'vue',
                ),
                UserPageIcon(
                  iconData: FontAwesomeIcons.react,
                  color: Colors.blue,
                  size: 34,
                  name: 'react',
                ),
              ],
            ),
          ),
          Card(
              margin: EdgeInsets.only(
                top: ScreenUtil.getInstance().setHeight(20),
                left: ScreenUtil.getInstance().setWidth(40),
                right: ScreenUtil.getInstance().setWidth(40),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Container(
                height: ScreenUtil.getInstance().setHeight(1000),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().setHeight(60)),
                      height: ScreenUtil.getInstance().setHeight(200),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(
                                ScreenUtil.getInstance().setWidth(40)),
                            alignment: Alignment.center,
                            height: ScreenUtil.getInstance().setHeight(150),
                            child: Text(
                              'Total budget for ${DateTime.now().month}',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  letterSpacing: 2.5,
                                  fontFamily: 'lobster'),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(
                                  ScreenUtil.getInstance().setWidth(30)),
                              alignment: Alignment.center,
                              height: ScreenUtil.getInstance().setHeight(150),
                              child: Consumer<BillModel>(
                                builder: (context, billModel, child) {
                                  return GestureDetector(
                                    onTap: () {
                                      _setBudget(context, billModel);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          ScreenUtil.getInstance()
                                              .setWidth(15)),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Text(
                                        '+ set budget ',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14,
                                            letterSpacing: 1.5,
                                            fontFamily: 'lobster'),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setWidth(80),
                          right: ScreenUtil.getInstance().setWidth(40),
                        ),
                        child: Consumer<BillModel>(
                          builder: (context, billModel, child) {
                            return Row(
                              children: <Widget>[
                                Container(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      CustomPaint(
                                        painter: CircularCanvas(
                                            progress: animation.value,
                                            backgroundColor: ColorUtil.getLight(
                                                Theme.of(context)
                                                    .primaryColorLight),
                                            color: Colors.blueAccent),
                                        size: Size(120, 120),
                                      ),
                                      Text(
                                        '${(animation.value / 360 * 100).round()}%',
                                        style: TextStyle(
                                            color: Colors.pink,
                                            fontSize: 120 / 5,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height:
                                        ScreenUtil.getInstance().setHeight(350),
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil.getInstance()
                                            .setWidth(100),
                                        top: ScreenUtil.getInstance()
                                            .setHeight(80)),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  'surplus:',
                                                  style: _getTextStyleByBudget(
                                                      billModel
                                                          .currentMonthBudget),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  '${billModel.currentMonthBudget == null ? 0.0 : billModel.currentMonthBudget - billModel.currentExpense}',
                                                  style: _getTextStyleByBudget(
                                                      billModel
                                                          .currentMonthBudget),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          color: Colors.black87,
                                          height: ScreenUtil.getInstance()
                                              .setHeight(1),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  'budget:',
                                                  style: _getTextStyleByBudget(
                                                      billModel
                                                          .currentMonthBudget),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  '${billModel.currentMonthBudget ?? 0.0}',
                                                  style: _getTextStyleByBudget(
                                                      billModel
                                                          .currentMonthBudget),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  'expend:',
                                                  style: _getTextStyleByBudget(
                                                      billModel
                                                          .currentMonthBudget),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  '${billModel.currentMonthBudget == null ? 0.0 : billModel.currentExpense}',
                                                  style: _getTextStyleByBudget(
                                                      billModel
                                                          .currentMonthBudget),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
