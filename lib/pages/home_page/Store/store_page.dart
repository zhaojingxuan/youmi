import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/global_vm.dart';
import 'package:youmi/repository/models/me_userinfo.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1D1D27),
        appBar: AppBar(
            backgroundColor: const Color(0xFF1D1D27),
            leading: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Image.asset(
                'assets/images/header.png', // 替换为你的图片路径
                width: 24.w,
                height: 24.w,
              ),
            ),
            actions: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                height: 32.w, // 高度
                decoration: BoxDecoration(
                  color: Color(
                      0x99000000), // 背景颜色，rgba(0, 0, 0, 0.6) 对应的 Flutter 颜色
                  borderRadius: BorderRadius.circular(100.0), // 圆角半径
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/jinbi.png',
                      width: 22.w,
                      height: 22.w,
                    ),
                    SizedBox(width: 8.w),
                    Selector<GlobalVm, MeUserinfo?>(
                        selector: (context, vm) => vm.meUserinfo,
                        builder: (context, meUserinfo, child) {
                          return Text(
                              meUserinfo?.coins.toString() ?? '0', // 金币数量
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ));
                        }),
                  ],
                ),
              ),
              SizedBox(
                width: 16.w,
              )
            ]),
        body: Column(
          children: [
            SizedBox(
              height: 16.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  // 设置背景渐变
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(43, 43, 54, 0.81),
                      Color.fromRGBO(43, 43, 54, 0.54),
                    ],
                  ),
                  // 设置边框
                  border: Border.all(
                    color: const Color.fromRGBO(43, 43, 54, 1),
                    width: 1,
                  ),
                  // 设置阴影
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(0, 0, 0, 0.2),
                      offset: const Offset(0, 6),
                      blurRadius: 6,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8.w),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).warm_reminder,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        )),
                    SizedBox(
                      height: 10.w,
                    ),
                    Text(S.of(context).payment_tips_1,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color.fromRGBO(172, 174, 187, 1),
                        )),
                    Text(S.of(context).payment_tips_2,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color.fromRGBO(172, 174, 187, 1),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
