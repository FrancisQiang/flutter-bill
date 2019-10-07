import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/bill_bean.dart';
import 'package:flutter_bill/component/list/slide_menu_item.dart';
import 'package:flutter_bill/config/my_const.dart';
import 'package:flutter_bill/util/provider_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillBeanItem extends StatelessWidget {
  const BillBeanItem(
      {Key key,
        this.index,
        this.remove,
        this.iconColor,
        this.iconAlgebra,
        @required this.item,
      })
      : assert(item != null),
        super(key: key);

  // 每个item的数据源
  final BillBean item;
  // 用来构造icon的代数
  final iconAlgebra;
  // 获取此时在列表的index
  final int index;
  // 删除方法
  final Function remove;
  // icon对应的颜色
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    // 侧滑拉出删除的滑动控制器
    ScrollController _scrollController = ScrollController();
    double width = ScreenUtil.getInstance().setWidth(1080);
    double itemHeight = ScreenUtil.getInstance().setHeight(300);
    // 获取名字
    String name = item.name;
    // 通过iconAlgebra构造Icon
    Icon icon = Icon(
        IconData(iconAlgebra,
            fontFamily: MyConst.ICON_FAMILY),
        size: ScreenUtil.getInstance().setWidth(72),
        color: Colors.white
    );
    return Container(
      height: itemHeight,
      child: Listener(
          onPointerUp: (d) {
            if (_scrollController.offset < (ScreenUtil.getInstance().setWidth(200))) {
              _scrollController.animateTo(0,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.linear);
            } else {
              _scrollController.animateTo(ScreenUtil.getInstance().setWidth(500),
                  duration: Duration(milliseconds: 200),
                  curve: Curves.linear);
            }
          },
          child: Container(
            height: itemHeight,
            margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil.getInstance().setWidth(20),
                vertical: itemHeight / 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                        Navigator.of(context).push(
                          new CupertinoPageRoute(
                            builder: (ctx) {
                              return ProviderUtil.getBillDetailPage(
                                  billBean: item,
                                  heroTag: "billBean$index",
                                  icon: Icon(
                                      IconData(
                                          iconAlgebra,
                                          fontFamily: MyConst
                                              .ICON_FAMILY),
                                      size: width / 15,
                                      color: iconColor),
                                  edit: true,
                                  index: index);
                            },
                          ),
                        );
                    },
                    child: Container(
                      height: itemHeight - 10,
                      width: width - ScreenUtil.getInstance().setWidth(40),
                      child: Card(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(20.0))),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Hero(
                                tag: "billBean$index",
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: (width - ScreenUtil.getInstance().setWidth(40)) / 20
                                  ),
                                  height: itemHeight / 8 * 5,
                                  width: itemHeight / 8 * 5,
                                  child: icon,
                                  decoration: BoxDecoration(
                                      color: iconColor == null
                                          ? Colors.red[200]
                                          : iconColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100.0))),
                                ),
                              ),
                              Container(
                                width: (width - ScreenUtil.getInstance().setWidth(40)) / 3.3,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        '$name',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            letterSpacing: 2.0,
                                            fontFamily: 'lobster',
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: itemHeight / 7),
                                      child: Text(
                                        '${item.remark}',
                                        overflow:
                                        TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            letterSpacing: 2.0,
                                            fontFamily: 'lobster',
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize: 15.0),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: (width - ScreenUtil.getInstance().setWidth(40)) / 20 * 3),
                                child: Text(
                                  '${item.type == MyConst.EXPEND ? -item.money : item.money}',
                                  style: TextStyle(
                                      color: Colors.red[500],
                                      letterSpacing: 2.0,
                                      fontFamily: 'lobster',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SlideMenuItem(
                    margin: EdgeInsets.only(
                        left: width / 40),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                        ),
                        color: Colors.redAccent,
                        child: Container(
                          alignment: Alignment.center,
                          width: width / 4,
                          height: itemHeight * 0.75,
                          child: Text(
                            'Delete',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 22.0,
                                fontFamily: 'lobster',
                                letterSpacing: 3.5),
                          ),
                        ),
                        onPressed: () {
                          _scrollController.animateTo(0,
                              duration: Duration(milliseconds: 100),
                              curve: Curves.linear);
                          remove(index);
                        }
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}