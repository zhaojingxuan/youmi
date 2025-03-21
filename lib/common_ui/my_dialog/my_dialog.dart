// 弹窗显示方法
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/route/route_utils.dart';

Future<void> showMyDialog(BuildContext context,
    {required String title,
    required Widget content,
    VoidCallback? surefunc,
    bool? showCancelbtn}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.black, // 设置为透明背景
      elevation: 0, // 去除默认阴影
      contentPadding: EdgeInsets.zero, // 清空默认内边距
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // 保持圆角
      ),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), // 与 shape 保持一致
          gradient: RadialGradient(
            center: Alignment(0.5015, -0.3013), // 对应 50.15% -30.13%
            radius: 0.8, // 根据效果调整半径
            colors: [
              Color.fromRGBO(185, 3, 85, 0.4), // rgba(185, 3, 85, 0.4)
              Color.fromRGBO(185, 3, 85, 0), // rgba(185, 3, 85, 0)
            ],
            stops: [0.0, 1.0], // 对应 0% 和 100%
            transform: GradientRotation(
              -0.5 * pi, // 可选旋转角度（根据实际效果调整）
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              content,
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (showCancelbtn == null || showCancelbtn)
                    TextButton(
                      onPressed: () => RouteUtils.pop(context),
                      child: Text(S.of(context).cancel,
                          style: TextStyle(color: Colors.white)),
                    ),
                  TextButton(
                    onPressed: () {
                      if (surefunc != null) {
                        surefunc();
                      } else {
                        RouteUtils.pop(context);
                      }
                    },
                    child: Text(S.of(context).ok,
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
