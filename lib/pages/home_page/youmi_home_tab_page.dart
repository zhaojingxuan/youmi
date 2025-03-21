import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:youmi/common_ui/navigation/Animation_click.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/pages/home_page/Discover/discover_page.dart';
import 'package:youmi/pages/home_page/Me/me_page.dart';
import 'package:youmi/pages/home_page/Shorts/shorts_page.dart';
import 'package:youmi/pages/home_page/Store/store_page.dart';
import 'package:youmi/pages/home_page/home_tab_share_data_vm.dart';
import 'package:youmi/common_ui/my_pop_scope/my_pop_scope.dart';
import 'package:youmi/repository/api.dart';
import 'package:youmi/route/route_utils.dart';
import 'package:youmi/route/routes.dart';

class _YoumiTabConfig {
  final Widget page;
  final String label;
  final Widget icon;
  final Widget activeIcon;

  const _YoumiTabConfig({
    required this.page,
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}

class YoumiHomeTabPage extends StatefulWidget {
  const YoumiHomeTabPage({super.key});

  @override
  State<YoumiHomeTabPage> createState() => _YoumiHomeTabPageState();
}

class _YoumiHomeTabPageState extends State<YoumiHomeTabPage> {
  List<_YoumiTabConfig> _tabConfig = [];

  final GlobalKey _tabkey = GlobalKey(); // 创建 GlobalKey

  HomeTabShareDataVm homeTabShareDataVm =
      HomeTabShareDataVm(showTabIndex: 0, tabHeight: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((st) {
      setState(() {
        _tabConfig = [
          _YoumiTabConfig(
            page:
                // Placeholder(),
                DiscoverPage(
              tabIndex: 0,
            ),
            label: S.of(context).main_discover,
            icon: Image.asset(
              "assets/images/DiscoverIcon.png",
              width: 26.h,
              height: 26.h,
            ),
            activeIcon: AnimationClick(builder: (context) {
              return Image.asset(
                "assets/images/DiscoverIconAct.png",
                width: 26.h,
                height: 26.h,
              );
            }),
          ),
          _YoumiTabConfig(
            page:
                // Placeholder(),
                ShortsPage(
              tabIndex: 1,
            ),
            label: S.of(context).main_shorts,
            icon: Image.asset(
              "assets/images/ShortsIcon.png",
              width: 26.h,
              height: 26.h,
            ),
            activeIcon: AnimationClick(builder: (context) {
              return Image.asset(
                "assets/images/ShortsIconAct.png",
                width: 26.h,
                height: 26.h,
              );
            }),
          ),
          _YoumiTabConfig(
            page: Container(),
            label: "",
            icon: Image.asset(
              "assets/images/bottommid.png",
              width: 40.h,
              height: 40.h,
            ),
            activeIcon: AnimationClick(builder: (context) {
              return Image.asset(
                "assets/images/bottommid.png",
                width: 40.h,
                height: 40.h,
              );
            }),
          ),
          _YoumiTabConfig(
            page:
                //  Placeholder(),
                StorePage(
              tabIndex: 3,
            ),
            label: S.of(context).main_store,
            icon: Image.asset(
              "assets/images/storeIcon.png",
              width: 26.h,
              height: 26.h,
            ),
            activeIcon: AnimationClick(builder: (context) {
              return Image.asset(
                "assets/images/storeIconAct.png",
                width: 26.h,
                height: 26.h,
              );
            }),
          ),
          _YoumiTabConfig(
            page:
                // Placeholder(),
                MePage(
              tabIndex: 4,
            ),
            label: S.of(context).main_mine,
            icon: Image.asset(
              "assets/images/meIcon.png",
              width: 26.h,
              height: 26.h,
            ),
            activeIcon: AnimationClick(builder: (context) {
              return Image.asset(
                "assets/images/meIconAct.png",
                width: 26.h,
                height: 26.h,
              );
            }),
          )
        ];
      });
      WidgetsBinding.instance.addPostFrameCallback((st) {
        final RenderBox renderBox =
            _tabkey.currentContext!.findRenderObject() as RenderBox;
        homeTabShareDataVm.setTabHeight(renderBox.size.height);
      });
    });
  }

  DateTime? _lastBackTime;

  @override
  Widget build(BuildContext context) {
    return MyPopScope(
        canBack: (bool b, Object? result) {
          if (homeTabShareDataVm.showTabIndex != 0) {
            homeTabShareDataVm.setShowTabIndex(0);
            return false;
          }
          final currentTime = DateTime.now();
          // 首次点击或超过2秒间隔
          if (_lastBackTime == null ||
              currentTime.difference(_lastBackTime!) >
                  const Duration(seconds: 2)) {
            _lastBackTime = currentTime;
            showToast('再按一次退出应用');
            return false;
          }
          return true;
        },
        child: Scaffold(
          // backgroundColor: Colors.amber, //把scaffold的背景色改成透明
          backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
          body: ChangeNotifierProvider(
            create: (context) {
              return homeTabShareDataVm;
            },
            child: Stack(
              children: [
                Builder(
                  builder: (context) {
                    // 这里的newContext是新的BuildContext
                    return Selector<HomeTabShareDataVm, int>(
                        selector: (context, vm) => vm.showTabIndex,
                        builder: (context, showTabIndex, child) {
                          return IndexedStack(
                            index: showTabIndex,
                            children: _tabConfig.map((i) => i.page).toList(),
                          );
                        });
                  },
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      key: _tabkey,
                      // height: 50.h,
                      // width: double.infinity,
                      padding: EdgeInsets.only(
                          top: 10.w,
                          bottom: MediaQuery.of(context).padding.bottom + 10.w),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(29, 29, 39, 0.9),
                        borderRadius: BorderRadius.circular(16.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.8), // 阴影颜色
                            blurRadius: 20, // 模糊半径 >= 圆角半径 * 2
                            spreadRadius: 2, // 扩散范围
                            offset: const Offset(0, -14),
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2), // 阴影颜色
                            blurRadius: 6,
                            spreadRadius: -2, // 反向收缩阴影
                            offset: const Offset(0, -12),
                          ),
                        ],
                        border: Border(
                          top: BorderSide(
                            // 设置边框的宽度，对应 CSS 中的 1px
                            width: 1,
                            // 设置边框的颜色，对应 CSS 中的 rgba(43, 43, 54, 1)
                            color: const Color.fromRGBO(43, 43, 54, 1),
                          ),
                        ),
                      ),
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int i = 0; i < _tabConfig.length; i++) _item(i)
                        ],
                      ),
                    ))
              ],
            ),
          ),
          // bottomNavigationBar:
        ));
  }

  Future clickMidItem() async {
    var historyList = (await Api.instance.userHistory());
    if (historyList?.isNotEmpty ?? false) {
      RouteUtils.pushForNamed(context, RoutePath.playPage, arguments: {
        "dramaId": historyList![0].dramaId,
      });
    }
  }

  Widget _item(int index) {
    _YoumiTabConfig item = _tabConfig[index];
    // return SizedBox.shrink();
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          if (index == 2) {
            clickMidItem();
          } else {
            homeTabShareDataVm.setShowTabIndex(index);
          }
        },
        child: Selector<HomeTabShareDataVm, int>(
            selector: (context, vm) => vm.showTabIndex,
            builder: (context, showTabIndex, child) {
              return Column(
                children: [
                  Builder(builder: (context) {
                    return showTabIndex == index ? item.activeIcon : item.icon;
                  }),
                  SizedBox(
                    height: 4.h,
                  ),
                  item.label.isNotEmpty
                      ? Builder(builder: (context) {
                          return AnimatedDefaultTextStyle(
                            style: TextStyle(
                              color: showTabIndex == index
                                  ? Colors.white
                                  : Color.fromRGBO(172, 174, 187, 1),
                              fontSize: 14.sp,
                            ),
                            duration: const Duration(microseconds: 500),
                            curve: Curves.easeInOut,
                            child: Text(item.label),
                          );
                        })
                      : SizedBox()
                ],
              );
            }));
  }
}
