import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPopScope extends StatelessWidget {
  final Widget child;

  final bool Function(
    bool,
    Object?,
  ) canBack;

  final void Function(BuildContext)? onBack;

  const MyPopScope(
      {super.key, required this.child, required this.canBack, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 禁止直接返回
      onPopInvokedWithResult: (b, result) => _handleBack(context, b, result),
      child: child,
    );
  }

  void _handleBack(BuildContext context, bool isLeading, Object? result) {
    if (canBack(isLeading, result)) {
      if (onBack != null) {
        onBack!(context);
      } else {
        _exitApp(context);
      }
    }
  }

  void _exitApp(BuildContext context) {
    // 跨平台退出方案
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop(); // Android/iOS
      // Web 端补充：if (kIsWeb) html.window.close();
    }
  }
}
