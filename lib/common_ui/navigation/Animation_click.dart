import 'package:flutter/material.dart';

///底部导航栏按钮
class AnimationClick extends StatefulWidget {
  const AnimationClick({super.key, required this.builder});

  final WidgetBuilder builder;

  @override
  State createState() => _AnimationClickState();
}

class _AnimationClickState extends State<AnimationClick>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    controller.forward();
    // controller.reverse();
    animation = Tween<double>(begin: 0.8, end: 1).animate(controller);

    // animation.addListener(() {
    //   // debugPrint(animation.value.toString());
    // });
    // animation.addStatusListener((AnimationStatus s) {
    //   // debugPrint("AnimationStatus: $s");
    // });
    // controller.addListener(() {
    //   // debugPrint("controller:${controller.value.toString()}");
    // });
  }

  @override
  void didChangeDependencies() {
    // 当前状态对象的依赖改变时
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant AnimationClick oldWidget) {
    // 组件配置更新时
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: animation, child: widget.builder(context));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
