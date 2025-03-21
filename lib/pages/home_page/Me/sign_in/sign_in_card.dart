import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/pages/home_page/Me/me_vm.dart';
import 'package:youmi/repository/models/store_sign_in/day.dart';
import 'package:youmi/repository/models/store_sign_in/store_sign_in.dart';

class SignInCard extends StatefulWidget {
  final int dDataIndex;
  final Day? beforeDData;
  const SignInCard({super.key, required this.dDataIndex, this.beforeDData});

  @override
  State<SignInCard> createState() => _SignInCardState();
}

class _SignInCardState extends State<SignInCard> {
  int get dDataIndex => widget.dDataIndex;
  Day? get beforeDData => widget.beforeDData;
  @override
  Widget build(BuildContext context) {
    return Selector<MeVm, StoreSignIn?>(
        selector: (_, vm) => vm.storeSignIn,
        builder: (context, storeSignIn, child) {
          print("Selector dData.type : ${storeSignIn!.day![dDataIndex].type}");

          var dData = storeSignIn.day![dDataIndex];

          return Container(
              margin: EdgeInsets.only(right: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut, // 动画曲线
                    padding: EdgeInsets.only(
                        top: 5.w, right: 6.w, left: 6.w, bottom: 8.w),
                    decoration: BoxDecoration(
                      color: ((storeSignIn?.isSignIn ?? false) ||
                              beforeDData?.type == 0 ||
                              dData.type == 1)
                          ? (dData.type == 0
                              ? Color.fromRGBO(29, 29, 39, 1)
                              : Color(0xFF2B2B36))
                          : null,
                      gradient: ((storeSignIn?.isSignIn ?? false) ||
                              beforeDData?.type == 0 ||
                              dData.type == 1)
                          ? null
                          : LinearGradient(
                              // 180deg 对应从顶部到底部，所以起始点是顶部中心
                              begin: Alignment.topCenter,
                              // 结束点是底部中心
                              end: Alignment.bottomCenter,
                              // 渐变的颜色列表，对应 CSS 中的颜色
                              colors: [
                                const Color(0xFFB90355),
                                const Color(0xFF530126),
                              ],
                              // 颜色的停止点，对应 CSS 中的百分比
                              stops: const [0.0, 1.0],
                            ),
                      borderRadius: BorderRadius.circular(8.0.w), // 圆角 8px
                      border: Border.all(
                        color: ((storeSignIn.isSignIn ?? false) ||
                                beforeDData?.type == 0 ||
                                dData.type == 1)
                            ? Color(0xFF2F2F3B)
                            : Color.fromRGBO(
                                255, 45, 111, 1), // 边框颜色 rgba(47, 47, 59, 1)
                        width: 1.0, // 边框宽度 1px
                      ),
                    ),
                    child: Column(
                      children: [
                        Text('+${dData.sigInProp?[0].number}'),
                        SizedBox(
                          height: 8.w,
                        ),
                        AnimatedSwitcher(
                          duration: 300.milliseconds,
                          transitionBuilder: (child, animation) {
                            // final offsetAnimation = Tween<Offset>(
                            //   begin: Offset(1.0, 0.0), // 从右侧进入
                            //   end: Offset.zero,
                            // ).animate(animation);
                            // return SlideTransition(
                            //   position: offsetAnimation,
                            //   child: child,
                            // );

                            // return RotationTransition(
                            //   turns: Tween<double>(begin: 0.0, end: 0.5)
                            //       .animate(animation), // 左右翻转半圈
                            //   alignment: Alignment.center, // 以中心轴翻转
                            //   child: child,
                            // );

                            final rotateAnim =
                                Tween(begin: pi, end: 0.0).animate(animation);
                            return AnimatedBuilder(
                              animation: rotateAnim,
                              child: child,
                              builder: (context, child) {
                                var tilt =
                                    ((animation.value - 0.5).abs() - 0.5) *
                                        0.003;
                                return Transform(
                                  transform: Matrix4.rotationY(rotateAnim.value)
                                    ..setEntry(3, 0, tilt),
                                  alignment: Alignment.center,
                                  child: Opacity(
                                    opacity: animation.value,
                                    child: child,
                                  ),
                                );
                              },
                            );
                          },
                          child: SizedBox(
                            key: ValueKey(dData.type == 1
                                ? 'assets/images/hassignin.png'
                                : dData.sigInProp?[0].image ?? ''),
                            width: 24.w,
                            height: 24.w,
                            child: (dData.type == 1)
                                ? Image.asset(
                                    'assets/images/hassignin.png',
                                    width: 24.w,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: dData.sigInProp?[0].image ?? '',
                                    width: 24.w,
                                  ),
                          ),
                        ),
                        // Text(
                        //     "dData.sigInProp?[0].image : ${dData.sigInProp?[0].image}"),
                      ],
                    ),
                  ),
                  Text(
                    '${S.of(context).day}${dData.day}',
                    style: TextStyle(fontSize: 14.sp),
                  )
                ],
              ));
        });
  }
}
