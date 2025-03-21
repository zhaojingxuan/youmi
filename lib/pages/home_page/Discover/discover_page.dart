import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youmi/common_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:youmi/pages/home_page/Discover/discover_vm.dart';
import 'package:youmi/pages/home_page/Discover/my_banner_header.dart';
import 'package:youmi/pages/home_page/Discover/my_floating_action_button.dart';
import 'package:youmi/pages/home_page/Discover/my_home_list_view.dart';
import 'package:youmi/pages/home_page/Discover/popular_now.dart';
import 'package:youmi/pages/home_page/home_tab_share_data_vm.dart';

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    // print("scaffoldGeometry.scaffoldSize:${scaffoldGeometry.scaffoldSize}");
    return Offset(scaffoldGeometry.scaffoldSize.width - 80.w,
        scaffoldGeometry.scaffoldSize.height - 200.w); // 自定义偏移量
  }
}

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key, required this.tabIndex});

  final int tabIndex;

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  RefreshController refreshController = RefreshController();
  DiscoverVm discoverVm = DiscoverVm();

  late ScrollController _scrollController;
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    discoverVm.getHomeData();
    discoverVm.getDramaData();

    _scrollController = ScrollController();
    // 监听滚动事件
    _scrollController.addListener(() {
      if (discoverVm.showScrollToTopButton != _scrollController.offset > 200) {
        // 当滚动距离超过 200 像素时，显示回到顶部按钮
        discoverVm.setShowScrollToTopButton(_scrollController.offset > 200);
      }
      // if (_showScrollToTopButton != _scrollController.offset > 200) {
      //   // 当滚动距离超过 200 像素时，显示回到顶部按钮
      //   _showScrollToTopButton = (_scrollController.offset > 200);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build discover page");
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/home_page.png"),
          fit: BoxFit.cover,
        )),
        child: ChangeNotifierProvider(
          create: (context) {
            return discoverVm;
          },
          child: Scaffold(
            backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
            floatingActionButtonLocation: CustomFloatingActionButtonLocation(),
            floatingActionButton: Myfloatingactionbutton(
              scrollController: _scrollController,
              // showScrollToTopButton: _showScrollToTopButton
            ),
            body: SmartRefreshWidget(
                controller: refreshController,
                scrollController: _scrollController,
                enablePullDown: true,
                enablePullUp: true,
                header: ClassicHeader(),
                footer: Selector<HomeTabShareDataVm, double>(
                    selector: (context, vm) => vm.tabHeight,
                    builder: (context, tabHeight, child) {
                      return CustomFooter(
                        height: (tabHeight) + 56.w,
                        builder: (BuildContext context, LoadStatus? mode) {
                          Widget body;
                          if (mode == LoadStatus.idle) {
                            body = Text("上拉加载更多",
                                style: TextStyle(color: Colors.grey));
                          } else if (mode == LoadStatus.loading) {
                            body = Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(strokeWidth: 2),
                                SizedBox(width: 10),
                                Text("加载中...",
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            );
                          } else if (mode == LoadStatus.failed) {
                            body = Text("加载失败，请重试",
                                style: TextStyle(color: Colors.red));
                          } else if (mode == LoadStatus.canLoading) {
                            body = Text("释放加载更多",
                                style: TextStyle(color: Colors.blue));
                          } else {
                            body = Text("没有更多数据了",
                                style: TextStyle(color: Colors.grey));
                          }
                          return Container(
                            padding: EdgeInsets.only(top: 16.w),
                            child: Center(child: body),
                          );
                        },
                      );
                    }),
                onLoading: () async {
                  // 上拉加载
                  if (await discoverVm.getDramaData(true)) {
                    refreshController.loadComplete();
                  } else {
                    refreshController.loadNoData();
                  }
                },
                onRefresh: () async {
                  // 下拉刷新
                  await discoverVm.getHomeData();
                  await discoverVm.getDramaData();
                  refreshController.refreshCompleted();
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: const MyBannerHeader(),
                    ),
                    SliverToBoxAdapter(
                      child: const MyHomeListView(),
                    ),
                    SliverToBoxAdapter(
                      child: const PopularNow(),
                    ),
                  ],
                )),
          ),
        ));
  }
}
