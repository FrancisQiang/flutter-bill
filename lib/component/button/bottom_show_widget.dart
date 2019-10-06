import 'package:circle_list/circle_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/bill_icon_bean.dart';
import 'package:flutter_bill/model/global_model.dart';
import 'package:flutter_bill/util/color_util.dart';
import 'package:flutter_bill/util/provider_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BottomShowWidget extends StatefulWidget {
  final VoidCallback onExit;
  final List<BillIconBean> billIconIncomeBeans;
  final List<BillIconBean> billIconExpenseBeans;

  BottomShowWidget(
      {this.onExit, this.billIconExpenseBeans, this.billIconIncomeBeans});

  @override
  _BottomShowWidgetState createState() => _BottomShowWidgetState();
}

class _BottomShowWidgetState extends State<BottomShowWidget>
    with SingleTickerProviderStateMixin {
  static const String _INCOME = 'income';
  static const String _EXPENSE = 'expense';

  AnimationController _controller;
  Animation<double> _animation;
  List<BillIconBean> _children = [];
  bool iconType = true;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = new Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuint));
    _controller.forward();
    _children.clear();
    _children.addAll(widget.billIconExpenseBeans);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime _lastPressedAt;
    return WillPopScope(
      // 防止误触
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          // 两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          return false;
        }
        doExit(context, _controller);
        return true;
      },
      child: GestureDetector(
        onTap: () {
          doExit(context, _controller);
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: ScreenUtil.getInstance().setWidth(1080),
            height: ScreenUtil.getInstance().setHeight(2340),
            child: AnimatedBuilder(
              animation: _animation,
              child: Consumer<GlobalModel>(
                builder: (context, globalModel, child) {
                  return CircleList(
                    origin: Offset(0, 0),
                    showInitialAnimation: true,
                    children: List.generate(_children.length, (index) {
                      return Builder(
                        builder: (context) {
                          BillIconBean billIconBean = _children[index];
                          // 创建对应icon
                          Icon icon = Icon(
                            IconBean.fromBean(billIconBean.iconBean),
                            size: 40,
                            color: ColorUtil.colorBeanToColor(
                                billIconBean.colorBean),
                          );
                          return IconButton(
                              onPressed: () {
                                doExit(context, _controller);
                                Navigator.of(context).push(
                                  new CupertinoPageRoute(
                                    builder: (ctx) {
                                      return ProviderUtil.getBillDetailPage(
                                              icon: icon,
                                              name: billIconBean.name,
                                              type: billIconBean.type,
                                              edit: false
                                      );
                                    },
                                  ),
                                );
                              },
                              tooltip: billIconBean.name,
                              icon: icon);
                        },
                      );
                    }),
                    innerCircleColor: Theme.of(context).primaryColorLight,
                    outerCircleColor: ColorUtil.getWhiteOrGrey(globalModel),
                    centerWidget: GestureDetector(
                        onTap: () {
                          // 切换 收入支出
                          setState(() {
                            iconType = !iconType;
                            _children.clear();
                            if (iconType) {
                              _children.addAll(widget.billIconExpenseBeans);
                            } else {
                              _children.addAll(widget.billIconIncomeBeans);
                            }
                          });
                        },
                        child: Container(
                            width: ScreenUtil.getInstance().setWidth(360),
                            height: ScreenUtil.getInstance().setWidth(360),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    child: child, scale: animation);
                              },
                              child: Text(
                                iconType ? _EXPENSE : _INCOME,
                                key: ValueKey<bool>(iconType),
                                style: TextStyle(
                                    fontSize: 30.0,
                                    color:
                                        ColorUtil.getWhiteOrGrey(globalModel),
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 2.0,
                                    fontFamily: 'lobster'),
                              ),
                            ))),
                  );
                },
              ),
              builder: (ctx, child) {
                return Transform.translate(
                    offset: Offset(
                        0,
                        ScreenUtil.getInstance().setHeight(2340) -
                            (_animation.value *
                                ScreenUtil.getInstance().setWidth(1080))),
                    child:
                        Transform.scale(scale: _animation.value, child: child));
              },
            ),
          ),
        ),
      ),
    );
  }

  void doExit(BuildContext context, AnimationController controller) {
    widget?.onExit();
    controller.reverse().then((r) {
      Navigator.of(context).pop();
    });
  }
}
