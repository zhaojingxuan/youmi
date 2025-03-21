import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:youmi/common_ui/video_player/custom_controls/custom_controls.dart';
import 'package:youmi/common_ui/video_player/types/handle_video_player_screen.dart';
import 'package:youmi/common_ui/video_player/types/video_item_info_t.dart';
import 'package:youmi/common_ui/video_player/video_share_data_vm.dart';
import 'package:youmi/common_ui/video_player/types/video_state.dart';
import 'package:youmi/common_ui/video_player/video_wait_loading.dart';
import 'package:youmi/common_ui/youmi_postar/youmi_poster.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/global_vm.dart';
import 'package:youmi/repository/api.dart';
import 'package:youmi/repository/models/drama_un_lock.dart';
import 'package:youmi/route/route_utils.dart';
import 'package:youmi/utils/string_utils.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoItemInfoT videoItemInfoT;
  final Widget? opWidget;
  final HandleVideoPlayerScreen? handle;

  const VideoPlayerScreen(
      {super.key, required this.videoItemInfoT, this.opWidget, this.handle});

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> with RouteAware {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  VideoItemInfoT get videoItemInfoT => widget.videoItemInfoT;
  HandleVideoPlayerScreen? get handle => widget.handle;

  VideoShareDataVm videoShareDataVm = VideoShareDataVm();

  Future<void> initControllerAndVm() async {
    // print('初始化视频控制器: ${videoItemInfoT.index} | ${videoItemInfoT.src}');
    final primaryColor = Theme.of(context).primaryColor;
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(videoItemInfoT.src!),
    );
    _videoPlayerController!.addListener(_listener);
    videoShareDataVm.setVideoPlayerController(_videoPlayerController!);

    try {
      await _videoPlayerController!.initialize();
    } catch (e) {
      videoShareDataVm.setVideoState(VideoState.error);
      return;
    }

    setState(() {
      // 初始化视频控制器
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
        // 其他自定义选项
        materialProgressColors: ChewieProgressColors(
          playedColor: primaryColor,
          //   handleColor: Colors.blue,
          //   backgroundColor: Colors.grey,
          //   bufferedColor: Colors.lightGreen,
        ),
        placeholder: Container(
          color: Colors.transparent,
        ),
        autoInitialize: true,
        allowedScreenSleep: false,

        // showControls: false, // 隐藏默认控件
        customControls: CustomControls(), // 使用自定义控制面板
      );
    });

    handle?.chewieController = _chewieController;
    handle?.videoPlayerController = _videoPlayerController;

    videoShareDataVm.changeOpBtn(widget.opWidget);
  }

  late GlobalVm globalVm;

  @override
  void initState() {
    super.initState();
    videoShareDataVm.setVideoItemInfoT(videoItemInfoT);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      globalVm = Provider.of<GlobalVm>(context, listen: false);
      if (videoItemInfoT.locking == 1 &&
          (!globalVm.automaticRelease || !await doDramaUnLock())) {
        return;
      }
      initControllerAndVm();
    });
  }

  Future<bool> doDramaUnLock() async {
    Map<String, dynamic> userDramaUnLockP = {
      "type": 1,
      "pay_type": 0,
      'drama_id': videoShareDataVm.videoItemInfoT!.dramaId,
      'ep_id': videoShareDataVm.videoItemInfoT!.epId,
    };

    userDramaUnLockP['sign'] = StringUtils.signData(userDramaUnLockP,
        '7ee6435d86e82eca1046eea5a81a6c1d1919ad88c3669e7adbbb3a608f6cfd42');

    DramaUnLock dramaUnLock =
        await Api.instance.userDramaUnLock(userDramaUnLockP);
    if (!StringUtils.isEmpty(dramaUnLock.ep)) {
      videoItemInfoT.locking = 0;
      videoItemInfoT.src = dramaUnLock.ep;
      videoShareDataVm.setVideoItemInfoT(videoItemInfoT.copyWith());

      globalVm.updateUserInfo();
      handle?.dramaUnLockOver
          ?.call(videoShareDataVm.videoItemInfoT!.index!, dramaUnLock.ep!);
      return true;
    }
    showToast("解锁失败");
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return videoShareDataVm;
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Selector<VideoShareDataVm,
                  ({VideoItemInfoT? videoItemInfoT, String? videoState})>(
              selector: (context, vm) => (
                    videoItemInfoT: vm.videoItemInfoT,
                    videoState: vm.videoState,
                  ),
              builder: (context, data, child) {
                return Center(
                    child: data.videoState != VideoState.loading &&
                            _chewieController != null
                        ? Chewie(
                            controller: _chewieController!,
                          )
                        : Stack(
                            children: [
                              VideoWaitLoading(
                                heroKeyTag:
                                    data.videoItemInfoT?.heroKeyTag ?? '',
                                imageUrl: data.videoItemInfoT?.picUrl ?? '',
                              ),
                              if (data.videoItemInfoT?.locking == 1 &&
                                  !Provider.of<GlobalVm>(context, listen: false)
                                      .automaticRelease)
                                Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: BackdropFilter(
                                        // color: Color.fromRGBO(29, 29, 39, 0.6),
                                        filter: ImageFilter.blur(
                                            sigmaX: 10, sigmaY: 10),
                                        child: Flex(
                                          direction: Axis.vertical,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            YoumiPoster(
                                              height: 291.h,
                                              // width: 208.w,
                                              fit: BoxFit.contain,
                                              postUrl:
                                                  data.videoItemInfoT?.picUrl ??
                                                      '',
                                            ),
                                            SizedBox(
                                              height: 20.w,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                if (await doDramaUnLock()) {
                                                  initControllerAndVm();
                                                }
                                              },
                                              child: Container(
                                                width: 211.w,
                                                height: 38.w,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    transform: GradientRotation(
                                                        50 * (pi / 180)),
                                                    colors: [
                                                      Color(0xFFFFE5C3),
                                                      Color(0xFFFF2D6F),
                                                      Color(0xFFB90355),
                                                      Color(0xFF780052),
                                                    ],
                                                    stops: [
                                                      0.1088,
                                                      0.4004,
                                                      0.6839,
                                                      0.8871
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                    color: Color.fromRGBO(
                                                        255, 45, 111, 1),
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Flex(
                                                  direction: Axis.horizontal,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                        'assets/images/lock.png',
                                                        width: 12.w),
                                                    SizedBox(width: 5.w),
                                                    Text(
                                                        S
                                                            .of(context)
                                                            .unlock_now,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )))
                            ],
                          ));
              }),
        ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 订阅 RouteObserver
    RouteUtils.routeObserver
        .subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    _videoPlayerController?.removeListener(_listener);
    videoShareDataVm.cancelDelayedTask();

    // 取消订阅
    RouteUtils.routeObserver.unsubscribe(this);

    if (videoItemInfoT.dramaId != null && videoItemInfoT.epId != null) {
      // 获取当前系统时间
      DateTime now = DateTime.now();
      // 定义日期时间格式
      DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      // 格式化日期时间
      String playTime = formatter.format(now);

      videoShareDataVm.createUserShow(
          dramaId: videoItemInfoT.dramaId!,
          epId: videoItemInfoT.epId!,
          playTime: playTime,
          playDuration: _playDuration.toString());
    }

    super.dispose();
  }

  int _playDuration = 0;

  void _listener() {
    if (_videoPlayerController == null) {
      return;
    }

    // 播放结束
    if (_videoPlayerController!.value.duration > Duration.zero &&
        _videoPlayerController!.value.position >=
            _videoPlayerController!.value.duration) {
      _videoPlayerController!.seekTo(Duration.zero);
      _videoPlayerController!.pause();
      videoShareDataVm.setIsShowControls(true);

      handle?.listenerOver?.call();
    }

    _playDuration =
        max(_playDuration, _videoPlayerController!.value.duration.inSeconds);

    String videoStatus = _videoPlayerController!.value.isPlaying
        ? VideoState.playing
        : VideoState.pause;

    if (_videoPlayerController!.value.isBuffering) {
      videoStatus = VideoState.buffering;
    }

    videoShareDataVm.setVideoState(videoStatus);
  }

  // 页面被推入栈顶（显示）
  @override
  void didPush() {
    print("页面被推入栈顶，显示");
    WakelockPlus.enable();
  }

  // 页面被弹出（隐藏）
  @override
  void didPop() {
    print("页面被弹出，隐藏");
    WakelockPlus.disable();
  }

  // 页面从隐藏变为显示（例如上一个页面被弹出）
  @override
  void didPopNext() {
    print("页面从隐藏变为显示");
    WakelockPlus.enable();
  }

  // 页面被其他页面覆盖（隐藏）
  @override
  void didPushNext() {
    print("页面被其他页面覆盖，隐藏");

    _chewieController?.pause();
    WakelockPlus.disable();
  }
}
