import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:youmi/common_ui/video_player/types/handle_video_player_screen.dart';
import 'package:youmi/common_ui/video_player/types/video_item_info_t.dart';
import 'package:youmi/common_ui/video_player/video_player_screen.dart';
import 'package:youmi/common_ui/youmi_loading/youmi_loading.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/pages/home_page/Shorts/shorts_vm.dart';
import 'package:youmi/pages/home_page/home_tab_share_data_vm.dart';
import 'package:youmi/repository/models/index_sale/item_sale.dart';
import 'package:youmi/route/route_utils.dart';
import 'package:youmi/route/routes.dart';

class ShortsPage extends StatefulWidget {
  const ShortsPage({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  State<ShortsPage> createState() => _ShortsPageState();
}

class _ShortsPageState extends State<ShortsPage> {
  ShortsVm viewModel = ShortsVm();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // viewModel.getListSale();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return viewModel;
    }, child: LayoutBuilder(
      builder: (context, constraints) {
        return Selector<HomeTabShareDataVm, double>(
            selector: (context, vm) => vm.tabHeight,
            builder: (context, tabHeight, child) {
              return Padding(
                padding: EdgeInsets.only(bottom: tabHeight),
                child: _ShortsWidget(
                  tabIndex: widget.tabIndex,
                ),
              );
            });
      },
    ));
  }
}

class _ShortsWidget extends StatelessWidget {
  final int tabIndex;
  const _ShortsWidget({required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return Selector<HomeTabShareDataVm, int>(
        selector: (context, vm) => vm.showTabIndex,
        builder: (context, showTabIndex, child) {
          return tabIndex == showTabIndex
              ? _VideoView()
              : Center(
                  child: YoumiLoading(),
                );
        });
  }
}

class _VideoView extends StatefulWidget {
  const _VideoView();

  @override
  State<_VideoView> createState() => __VideoViewState();
}

class __VideoViewState extends State<_VideoView> {
  // PageController 用于控制 PageView 的滑动
  final SwiperController _swiperController = SwiperController();
  // 当前显示视频的索引
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    debugPrint('ShortsPage initState');

    WidgetsBinding.instance.addPostFrameCallback((st) {
      // 通过 context 获取到 ViewModel
      ShortsVm vm = Provider.of<ShortsVm>(context, listen: false);
      vm.getListSale();
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('ShortsPage build');
    return Selector<ShortsVm, List<ItemSale>>(
        selector: (context, vm) => vm.listSale,
        builder: (context, listSale, child) {
          return Swiper(
            controller: _swiperController,
            scrollDirection: Axis.vertical, // 设置滚动方向为垂直
            itemCount: listSale.length, // 轮播项的数量
            onIndexChanged: (value) {
              _currentIndex = value;
            },
            itemBuilder: (context, index) {
              return VideoPlayerScreen(
                handle: HandleVideoPlayerScreen(listenerOver: () {
                  _swiperController.next();
                }),
                videoItemInfoT: VideoItemInfoT(
                  dramaId: listSale[index].dramaId ?? 0,
                  epId: listSale[index].epId ?? 0,
                  dramaName: listSale[index].dramaName ?? '',
                  desc: listSale[index].epDesc ?? '',
                  picUrl: listSale[index].dramaUrl ?? '',
                  src: listSale[index].ep ?? '',
                  like: listSale[index].like ?? 0,
                  collect: listSale[index].collect ?? 0,
                  likeNumber: listSale[index].likeNumber ?? 0,
                  collectNumber: listSale[index].collectNumber ?? 0,
                  forwardNumber: listSale[index].forwardNumber ?? 0,
                ),
                opWidget: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      RouteUtils.pushForNamed(context, RoutePath.playPage,
                          arguments: {
                            "dramaId": listSale[index].dramaId,
                          });
                    },
                    child: _opWidget()),
              );
            },
          );
        });
  }

  Widget _opWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/seemore.png",
                  width: 20.w,
                  height: 20.w,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(S.of(context).watch_full_episodes,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    )),
              ],
            )),
        Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: Icon(Icons.arrow_forward_ios_rounded,
              color: Colors.white, size: 16.w),
        )
      ],
    );
  }
}
