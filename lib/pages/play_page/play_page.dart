import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:youmi/common_ui/video_player/types/handle_video_player_screen.dart';
import 'package:youmi/common_ui/video_player/types/video_item_info_t.dart';
import 'package:youmi/common_ui/video_player/video_player_screen.dart';
import 'package:youmi/global_vm.dart';
import 'package:youmi/pages/play_page/drawer_bottom.dart';
import 'package:youmi/pages/play_page/play_page_vm.dart';
import 'package:youmi/pages/play_page/speed_icon.dart';
import 'package:youmi/repository/models/drama_list/drama_item.dart';
import 'package:youmi/repository/models/me_userinfo.dart';
import 'package:youmi/utils/string_utils.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final SwiperController _swiperController = SwiperController();
  PlayPageVm playPageVm = PlayPageVm();
  // 当前显示视频的索引

  late int dramaId;

  late HandleVideoPlayerScreen handleVideoPlayerScreen;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    handleVideoPlayerScreen = HandleVideoPlayerScreen(listenerOver: () {
      _swiperController.next();
    }, dramaUnLockOver: (int index, String ep) {
      playPageVm.setDramaListItem(index: index, obj: {
        'ep': ep,
        'locking': 0,
      });
      // playPageVm.getDramaList(dramaId: dramaId);
    });

    WidgetsBinding.instance.addPostFrameCallback((st) async {
      var map = ModalRoute.of(context)?.settings.arguments;
      if (map is Map) {
        dramaId = map['dramaId'];
        playPageVm.getDramaList(dramaId: dramaId);
      }
    });
  }

  double selectedSpeed = 1.0;
  final GlobalKey buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)?.settings.arguments;
    String? picUrl;
    String? heroKeyTag;
    if (map is Map) {
      picUrl = map['picUrl'];
      heroKeyTag = map['heroKeyTag'];
    }
    return ChangeNotifierProvider(
        create: (context) {
          return playPageVm;
        },
        child: Scaffold(
            backgroundColor: const Color(0xFF1D1D27),
            body: Selector<PlayPageVm, List<DramaItem>>(
                selector: (context, vm) => vm.listDrama,
                shouldRebuild: (prev, next) {
                  if (prev != next) return true;
                  for (var i = 0; i < prev.length; i++) {
                    if (prev[i] != next[i]) return true;
                  }
                  return false;
                },
                builder: (context, listDrama, child) {
                  return Stack(
                    children: [
                      if (!StringUtils.isEmpty(picUrl) &&
                          !StringUtils.isEmpty(heroKeyTag))
                        Opacity(
                            opacity: listDrama.isNotEmpty ? 0 : 1,
                            child: VideoPlayerScreen(
                              videoItemInfoT: VideoItemInfoT(
                                  picUrl: picUrl!, heroKeyTag: heroKeyTag),
                            )),
                      if (listDrama.isNotEmpty)
                        Swiper(
                          controller: _swiperController,
                          index: playPageVm.currentIndex,
                          loop: false,
                          scrollDirection: Axis.vertical, // 设置滚动方向为垂直
                          itemCount: listDrama.length, // 轮播项的数量
                          onIndexChanged: (value) {
                            playPageVm.currentIndex = value;
                          },
                          itemBuilder: (context, index) {
                            var dramaItem = listDrama[index];
                            return VideoPlayerScreen(
                              handle: handleVideoPlayerScreen,
                              videoItemInfoT: VideoItemInfoT(
                                dramaId: dramaItem.dramaId ?? 0,
                                epId: dramaItem.epId ?? 0,
                                dramaName: playPageVm.dramaName,
                                desc: dramaItem.epDesc ?? '',
                                picUrl: dramaItem.coverUrl ?? '',
                                src: dramaItem.ep ?? '',
                                like: dramaItem.like ?? 0,
                                collect: dramaItem.collect ?? 0,
                                likeNumber: dramaItem.likeNumber ?? 0,
                                collectNumber: dramaItem.collectNumber ?? 0,
                                forwardNumber: dramaItem.forwardNumber ?? 0,
                                locking: dramaItem.locking ?? 1,
                                index: index,
                              ),
                              opWidget: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    clickOpWidget(listDrama);
                                  },
                                  child: Container(
                                    child: _opWidget(
                                        playPageVm.total, dramaItem.sort ?? 0),
                                  )),
                            );
                          },
                        ),
                      Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: AppBar(
                            backgroundColor: Colors.transparent,
                            leading: Row(children: [
                              IconButton(
                                icon: Image.asset(
                                    "assets/images/back-image.png",
                                    width: 32.w,
                                    height: 32.w),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(width: 10.w),
                              Image.asset(
                                'assets/images/header.png', // 替换为你的图片路径
                                width: 32.w,
                                height: 32.w,
                              )
                            ]),
                            leadingWidth: 100.w,
                            centerTitle: false,
                            actions: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                height: 32.w, // 高度
                                decoration: BoxDecoration(
                                  color: Color(
                                      0x99000000), // 背景颜色，rgba(0, 0, 0, 0.6) 对应的 Flutter 颜色
                                  borderRadius:
                                      BorderRadius.circular(100.0), // 圆角半径
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
                                        selector: (context, vm) =>
                                            vm.meUserinfo,
                                        builder: (context, meUserinfo, child) {
                                          return Text(
                                              meUserinfo?.coins.toString() ??
                                                  '0', // 金币数量
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp,
                                              ));
                                        }),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16.w),
                              PopupMenuButton<double>(
                                position: PopupMenuPosition.under,
                                key: buttonKey,
                                // offset:
                                //     _calculateOffset(buttonKey, 32.w), // 动态计算偏移量
                                offset: Offset(16.w, 6.w),
                                onSelected: (double result) {
                                  selectedSpeed = result;
                                  handleVideoPlayerScreen.videoPlayerController
                                      ?.setPlaybackSpeed(result);
                                },
                                // color: Colors.transparent,
                                color: Colors.black
                                    .withValues(alpha: 0.7), // 半透明背景
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  // side: BorderSide(color: Colors.black87), // 半透明边框
                                ),
                                constraints: BoxConstraints(),
                                itemBuilder: (BuildContext context) => [
                                  0.5,
                                  1.0,
                                  1.25,
                                  1.5,
                                  1.75,
                                  2.0
                                ].map((double value) {
                                  return PopupMenuItem<double>(
                                    padding: EdgeInsets.zero,
                                    value: value,
                                    child: Center(
                                      child: SpeedIcon(
                                        speed: value,
                                        color: value == selectedSpeed
                                            ? Color.fromRGBO(255, 45, 111, 1)
                                            : Color(0x99000000),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                child: SpeedIcon(
                                  speed: selectedSpeed,
                                  color: Color(0x99000000),
                                ),
                              ),
                              SizedBox(width: 16.w),
                            ],
                          ))
                    ],
                  );
                })));
  }

  void clickOpWidget(List<DramaItem> listDrama) {
    showModalBottomSheet(
        context: context,
        // useSafeArea: true,
        builder: (BuildContext context) {
          return DrawerBottom(
            currentIndex: playPageVm.currentIndex,
            listDrama: listDrama,
            callback: (int i) {
              Navigator.pop(context);
              _swiperController.move(i);
            },
          );
        });
  }

  Widget _opWidget(int total, int sort) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: DefaultTextStyle(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
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
                    Text(
                      'EP.$sort',
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Container(
                      color: Colors.white,
                      width: 1.w,
                      height: 20.w,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      '${total}EP',
                    ),
                  ],
                ))),
        Padding(
          padding: EdgeInsets.only(right: 10.w),
          child:
              Icon(Icons.expand_less_rounded, color: Colors.white, size: 16.w),
        )
      ],
    );
  }
}
