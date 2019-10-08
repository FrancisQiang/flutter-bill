import 'package:flutter/material.dart';
import 'package:flutter_bill/util/provider_util.dart';
import 'package:flutter_bill/util/show_full_screen_dialog_util.dart';

import 'package:flutter_bill/component/button/bottom_show_widget.dart';

class AnimatedFloatingButton extends StatefulWidget {

  const AnimatedFloatingButton({Key key}) : super(key: key);

  @override
  _AnimatedFloatingButtonState createState() => _AnimatedFloatingButtonState();
}

class _AnimatedFloatingButtonState extends State<AnimatedFloatingButton>
    with SingleTickerProviderStateMixin {
  // 动画控制器
  AnimationController _controller;
  // 动画
  Animation _animation;

  // 初始化
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (ctx, child) {
        return Transform.translate(
          // 使下移
          offset: Offset(0, (_animation.value) * 60),
          child: Transform.scale(scale: 1 - _animation.value, child: child),
        );
      },
      child: FloatingActionButton(
          onPressed: () async {
            _controller.forward();
            ShowFullScreenDialogUtil.showDialog(
                context: context,
                child: BottomShowWidget(
                  onExit: () {
                    _controller.reverse();
                  },
                  billIconExpenseBeans: await ProviderUtil.iconSettingModel.getExpenseIconWithCache(),
                  billIconIncomeBeans: await ProviderUtil.iconSettingModel.getIncomeIconWithCache(),
                )
            );
          },
          child: Icon(
            Icons.add,
            size: 28.0,
            color: Colors.white,
          ),
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0)))
      ),
    );
  }
}
