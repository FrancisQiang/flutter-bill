import 'package:flutter/material.dart';
import 'package:flutter_bill/util/theme_util.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconWidget extends StatefulWidget {
  final Function onApplyTap;
  final Color pickerColor;
  final String iconName;

  CustomIconWidget({
    this.onApplyTap,
    this.pickerColor,
    this.iconName,
  })  : assert(onApplyTap != null),
        assert(pickerColor != null);

  @override
  _CustomIconWidgetState createState() => _CustomIconWidgetState();
}

class _CustomIconWidgetState extends State<CustomIconWidget> {

  final List<Color> defaultColors = [
    MyThemeColor.blueGrayColor,
    MyThemeColor.darkColor,
    MyThemeColor.greenColor,
    MyThemeColor.purpleColor,
    MyThemeColor.cyanColor,
    MyThemeColor.coffeeColor,
    MyThemeColor.defaultColor,
    Colors.orange,
    Colors.cyanAccent
  ];

  Color currentIconColor;
  int currentSelectIndex;

  @override
  void initState() {
    super.initState();
    currentIconColor = widget.pickerColor;
    currentSelectIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(350),
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(defaultColors.length, (index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      currentSelectIndex = index;
                      currentIconColor = defaultColors[index];
                    });
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: defaultColors[index],
                      border: currentSelectIndex == index
                          ? Border.all(width: 2, color: Colors.black)
                          : null,
                    ),
                  ),
                );
              }),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _showColorPicker(context);
                  },
                  child: Container(
                    height: ScreenUtil.getInstance().setWidth(100),
                    width: ScreenUtil.getInstance().setWidth(100),
                    margin: EdgeInsets.only(
                      top: ScreenUtil.getInstance().setHeight(40),
                      left: ScreenUtil.getInstance().setWidth(20),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.yellowAccent,
                          Colors.deepOrange,
                          Colors.greenAccent,
                          Colors.blueAccent,
                          Colors.cyan
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: currentSelectIndex == defaultColors.length
                          ? Border.all(color: currentIconColor, width: 2)
                          : null,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      height: ScreenUtil.getInstance().setWidth(100),
                      margin: EdgeInsets.only(
                        top: ScreenUtil.getInstance().setHeight(40),
                      ),
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        child: Text(
                          'cancel',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: ScreenUtil.getInstance().setWidth(100),
                    margin: EdgeInsets.only(
                      top: ScreenUtil.getInstance().setHeight(40),
                    ),
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      child: Text(
                        'ok',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        widget.onApplyTap(currentIconColor);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showColorPicker(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            elevation: 0.0,
            title: Center(child: Text(
              'Choose a color',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 28.0,
                  letterSpacing: 1.5,
                  fontFamily: 'lobster'
              ),
            ),),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: currentIconColor,
                onColorChanged: (color) {
                  currentIconColor = color;
                  currentSelectIndex = defaultColors.length;
                },
                enableLabel: true,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'cancel',
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  currentIconColor = widget.pickerColor;
                  currentSelectIndex = -1;
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('ok'),
                onPressed: () {
                  setState(() {});
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
