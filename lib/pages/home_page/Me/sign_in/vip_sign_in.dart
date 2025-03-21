import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/global_vm.dart';
import 'package:youmi/pages/home_page/Me/me_vm.dart';
import 'package:youmi/pages/home_page/Me/sign_in/sign_in_card.dart';

class VipSignIn extends StatefulWidget {
  const VipSignIn({super.key});

  @override
  State<VipSignIn> createState() => _VipSignInState();
}

class _VipSignInState extends State<VipSignIn>
    with SingleTickerProviderStateMixin {
  late MeVm meVm;
  late AnimationController _controllerAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    meVm = Provider.of<MeVm>(context, listen: false);
    meVm.vipStoreSignIn();

    _controllerAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<MeVm, MeVm>(
      selector: (_, model) => model,
      shouldRebuild: (previous, next) {
        // 自定义判断条件
        return previous.storeSignIn != next.storeSignIn ||
            previous.today != next.today ||
            previous.todayKey != next.todayKey;
      },
      builder: (context, vm, child) {
        return vm.storeSignIn != null &&
                vm.storeSignIn!.day != null &&
                vm.storeSignIn!.day!.isNotEmpty
            ? Align(
                alignment: Alignment.center,
                child: Container(
                    width: 343.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0.w),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x6F2B2B36), // rgba(43, 43, 54, 0.81)
                          Color(0x8A2B2B36), // rgba(43, 43, 54, 0.54)
                        ],
                      ),
                      border: Border.all(
                        color: Color(0xFF2B2B36), // rgba(43, 43, 54, 1)
                        width: 1.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x33000000), // rgba(0, 0, 0, 0.2)
                          blurRadius: 6,
                          offset: Offset(0, 6), // 阴影偏移量
                        ),
                      ],
                    ),
                    child: DefaultTextStyle(
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16.sp,
                          height: 1.5,
                        ),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(S.of(context).daily_check,
                                    style: TextStyle(fontSize: 16.sp)),
                                SizedBox(
                                  height: 10.w,
                                ),
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        for (int i = 0;
                                            i < vm.storeSignIn!.day!.length;
                                            i++)
                                          SignInCard(
                                            key: (vm.storeSignIn!.day![i].day ==
                                                    vm.today?.day)
                                                ? vm.todayKey
                                                : null,
                                            dDataIndex: i,
                                            beforeDData: i - 1 >= 0
                                                ? vm.storeSignIn!.day![i - 1]
                                                : null,
                                          )
                                      ],
                                    )),
                                SizedBox(
                                  height: 20.h,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (meVm.today == null) {
                                          // showToast("今日无可签到内容");
                                          return;
                                        }
                                        _addToCart();
                                        await vm.userSignAction();
                                        Provider.of<GlobalVm>(context,
                                                listen: false)
                                            .updateUserInfo();
                                      },
                                      child: Container(
                                        width: 211.w,
                                        height: 32.w,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/checkinbg.png'), // Use an image from assets
                                            fit: BoxFit
                                                .cover, // Adjusts how the image fits within the container
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  16)), // border-radius
                                        ),
                                        child: Center(
                                          child: Text(
                                            S.of(context).check_in,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )))),
              )
            : SizedBox.shrink();
      },
    );
  }

  void _addToCart() async {
    // from 位置
    final RenderBox itemBox =
        meVm.todayKey.currentContext?.findRenderObject() as RenderBox;
    final Offset itemPosition = itemBox.localToGlobal(Offset.zero);

    // to 位置
    final RenderBox cartBox =
        meVm.headerjbKey.currentContext?.findRenderObject() as RenderBox;
    final Offset cartPosition = cartBox.localToGlobal(Offset.zero);

    // 创建覆盖层
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => AnimatedBuilder(
        animation: _controllerAnimation,
        builder: (context, child) {
          // 抛物线路径计算
          final double progress =
              Curves.easeInOutBack.transform(_controllerAnimation.value);
          final double x = (cartPosition.dx - itemPosition.dx) * progress;
          final double y =
              (cartPosition.dy - itemPosition.dy) * progress * (2 - progress);

          // 缩放和透明度变化
          // final double scale = 1 - progress * 0.5;
          final double opacity = max(0, min(1 - progress * 0.8, 1));

          final double scale = 1 - 0 * 0.5;

          return Positioned(
            left: itemPosition.dx + x,
            top: itemPosition.dy + y,
            child: Transform.scale(
              scale: scale,
              child: Opacity(
                opacity: opacity,
                child: CachedNetworkImage(
                  imageUrl: meVm.today?.sigInProp?[0].image ?? '',
                  width: 24.w,
                ),
              ),
            ),
          );
        },
      ),
    );

    // 插入覆盖层
    Overlay.of(context).insert(overlayEntry);

    // 启动动画
    await _controllerAnimation.forward(from: 0);

    // 移除覆盖层并更新数量
    overlayEntry.remove();
  }
}
