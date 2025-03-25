import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youmi/common_ui/youmi_loading/youmi_loading.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/global_vm.dart';
import 'package:youmi/pages/home_page/Me/me_vm.dart';
import 'package:youmi/pages/home_page/Me/sign_in/vip_sign_in.dart';
import 'package:youmi/pages/home_page/Me/task/vip_task.dart';
import 'package:youmi/pages/home_page/Me/vip_store_card/vip_store_card_list.dart';
import 'package:youmi/pages/home_page/home_tab_share_data_vm.dart';
import 'package:youmi/repository/models/history_list/history.dart';
import 'package:youmi/repository/models/me_userinfo.dart';
import 'package:youmi/repository/models/op_action_list/action_datum.dart';
import 'package:youmi/route/route_utils.dart';
import 'package:youmi/route/routes.dart';

class MePage extends StatefulWidget {
  const MePage({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  MeVm meVm = MeVm();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("initState _MePageState");
    meVm.getUserStoreVip();
    meVm.vipStoreSignIn();
    meVm.getVipTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return meVm;
        },
        child: Selector<HomeTabShareDataVm, int>(
            selector: (context, vm) => vm.showTabIndex,
            builder: (context, showTabIndex, child) {
              return widget.tabIndex == showTabIndex
                  ? _MeView()
                  : Center(
                      child: YoumiLoading(),
                    );
            }));
  }
}

class _MeView extends StatefulWidget {
  const _MeView();

  @override
  State<_MeView> createState() => __MeViewState();
}

class __MeViewState extends State<_MeView> {
  final ScrollController _scrollController = ScrollController();
  double _imageOpacity = 0.0;

  @override
  void initState() {
    debugPrint("initState __MeViewState");
    // TODO: implement initState
    super.initState();
    Provider.of<GlobalVm>(context, listen: false).updateUserInfo();

    _scrollController.addListener(() {
      // 根据滚动偏移量计算图片的透明度，这里假设在滚动 200 像素时图片完全显示
      var _imageOpacity_t = _scrollController.offset / 200;
      _imageOpacity_t =
          double.parse(min(1, max(0, _imageOpacity_t)).toStringAsFixed(1));
      if (_imageOpacity_t != _imageOpacity) {
        setState(() {
          _imageOpacity = _imageOpacity_t;
        });
      }
    });
  }

  Widget headerImage(MeUserinfo? meUserinfo, {double? width, double? height}) {
    width ??= 24.w;
    height ??= 24.w;
    return meUserinfo?.userImage != null
        ? CachedNetworkImage(
            imageUrl: meUserinfo?.userImage,
            width: width,
            height: height,
          )
        : Image.asset(
            'assets/images/header.png', // 替换为你的图片路径
            width: width,
            height: height,
          );
  }

  List<History>? historyList;

  List<ActionDatum> likeList = [];
  List<ActionDatum> collectList = [];

  @override
  Widget build(BuildContext context) {
    return Selector<GlobalVm, MeUserinfo?>(
        selector: (_, vm) => vm.meUserinfo,
        builder: (context, meUserinfo, child) {
          return Scaffold(
              backgroundColor: const Color(0xFF1D1D27),
              appBar: AppBar(
                  backgroundColor: const Color(0xFF1D1D27),
                  leading: AnimatedOpacity(
                    duration: Duration(milliseconds: 100),
                    opacity: _imageOpacity,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Image.asset(
                        'assets/images/header.png', // 替换为你的图片路径
                        width: 24.w,
                        height: 24.w,
                      ),
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
                          Selector<MeVm, GlobalKey>(
                              selector: (_, vm) => vm.headerjbKey,
                              builder: (context, headerjbKey, child) {
                                return Image.asset(
                                  'assets/images/jinbi.png',
                                  key: headerjbKey,
                                  width: 22.w,
                                  height: 22.w,
                                );
                              }),
                          SizedBox(width: 8.w),
                          Text(meUserinfo?.coins.toString() ?? '0', // 金币数量
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              )),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Image.asset(
                        "assets/images/setting.png",
                        width: 32.w,
                      ), // 替换为你的图片路径
                      onPressed: () {
                        // 执行某些操作
                        RouteUtils.pushForNamed(context, RoutePath.setting);
                      },
                    ),
                  ]),
              body: SafeArea(
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            headerImage(meUserinfo, width: 80.w, height: 80.w),
                            Expanded(
                                child: Container(
                                    padding: EdgeInsets.only(left: 16.w),
                                    height: 80.w, // 高度撑满，让 Column 的高度由 Row 决定
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            meUserinfo?.userName ?? '',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.sp),
                                          ),
                                          if (meUserinfo?.vip == true)
                                            Image.asset(
                                              "assets/images/vip.png",
                                              width: 22.w,
                                            )
                                          else
                                            Image.asset(
                                              "assets/images/novip.png",
                                              width: 22.w,
                                            )
                                        ])))
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 20.w, horizontal: 18.w),
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          // 线性渐变背景
                          gradient: LinearGradient(
                            begin: Alignment.topCenter, // 渐变起始位置
                            end: Alignment.bottomCenter, // 渐变结束位置
                            colors: [
                              const Color(
                                  0xCF2B2B36), // rgba(43, 43, 54, 0.81)，0xCF 表示透明度 0.81
                              const Color(
                                  0x8A2B2B36), // rgba(43, 43, 54, 0.54)，0x8A 表示透明度 0.54
                            ],
                          ),
                          // 阴影
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                  0x33000000), // rgba(0, 0, 0, 0.2)，0x33 表示透明度 0.2
                              offset: const Offset(0, 6), // 阴影偏移量
                              blurRadius: 6, // 阴影模糊半径
                            ),
                          ],
                          // 圆角
                          borderRadius: BorderRadius.circular(8),
                          // 边框
                          border: Border.all(
                            width: 1,
                            color: Colors.black, // 可以根据需要调整边框颜色
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            menuItem(
                                assetUrl: "assets/images/History.png",
                                text: S.of(context).history,
                                func: () async {
                                  historyList = await RouteUtils.pushForNamed(
                                    context,
                                    RoutePath.history,
                                    arguments: {
                                      'historyList': historyList ?? []
                                    },
                                  );
                                }),
                            menuItem(
                                assetUrl: "assets/images/Favorites.png",
                                text: S.of(context).favorites,
                                func: () async {
                                  var res = await RouteUtils.pushForNamed(
                                    context,
                                    RoutePath.favorites,
                                    arguments: {
                                      'likeList': likeList,
                                      'collectList': collectList
                                    },
                                  );

                                  likeList = res?['likeList'] ?? [];
                                  collectList = res?['collectList'] ?? [];
                                }),
                            menuItem(
                                assetUrl: "assets/images/Bill.png",
                                text: S.of(context).bill,
                                func: () async {
                                  showToast('Coming soon!');
                                }),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: const VipStoreCardList(),
                    ),
                    SliverToBoxAdapter(
                      child: const VipSignIn(),
                    ),
                    SliverToBoxAdapter(
                      child: const VipTask(),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 200.h,
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  Widget menuItem(
      {required String assetUrl,
      required String text,
      required VoidFutureCallBack func}) {
    return GestureDetector(
        onTap: func,
        child: Column(
          children: [
            Image.asset(
              assetUrl,
              width: 38.w,
              height: 36.85.w,
            ),
            Hero(
                tag: 'page-title-$text',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    text,
                    overflow: TextOverflow.visible, // 允许溢出
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                )),
          ],
        ));
  }
}
