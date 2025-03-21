import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpeedIcon extends StatelessWidget {
  final double speed;
  final Color color;
  const SpeedIcon({super.key, required this.speed, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.w, // 高度
      width: 32.w, // 宽度
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            height: 32.w, // 高度
            width: 32.w, // 宽度
            decoration: BoxDecoration(
              color: color, // 背景颜色，rgba(0, 0, 0, 0.6) 对应的 Flutter 颜色
              borderRadius: BorderRadius.circular(100.0), // 圆角半径
            ),
          ),
          Center(
            child: Image.asset("assets/images/speed_Vector.png",
                width: 24.w, height: 24.w),
          ),
          Center(
            child: Image.asset("assets/images/speed_Vector1.png",
                width: 8.w, height: 8.w),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "$speed",
              style: TextStyle(
                color: Colors.white,
                fontSize: 8.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}
