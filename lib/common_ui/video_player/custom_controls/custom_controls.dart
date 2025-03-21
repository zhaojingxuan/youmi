import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:youmi/common_ui/video_player/custom_controls/my_pause_play_btn.dart';
import 'package:youmi/common_ui/video_player/custom_controls/my_video_progress.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:youmi/common_ui/video_player/custom_controls/user_operate.dart';
import 'package:youmi/common_ui/video_player/custom_controls/video_info.dart';
import 'package:youmi/common_ui/video_player/video_share_data_vm.dart';
import 'package:youmi/common_ui/video_player/types/video_state.dart';
import 'package:youmi/common_ui/youmi_loading/youmi_loading.dart';

class CustomControls extends StatefulWidget {
  const CustomControls({
    super.key,
  });

  @override
  State<CustomControls> createState() => _CustomControlsState();
}

class _CustomControlsState extends State<CustomControls>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationControllerMyVideoProgress;
  VideoShareDataVm? videoShareDataVm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationControllerMyVideoProgress = AnimationController(
      vsync: this,
      duration: 500.microseconds,
    );

    videoShareDataVm = Provider.of<VideoShareDataVm>(context, listen: false);
    videoShareDataVm?.addListener(_onShowControlsChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      videoShareDataVm?.setIsShowControls(true);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationControllerMyVideoProgress.dispose();
    videoShareDataVm?.removeListener(_onShowControlsChange);
    super.dispose();
  }

  void _changeShow() {
    videoShareDataVm?.changeShow();
  }

  void _onShowControlsChange() {
    if (videoShareDataVm!.isShowControls) {
      _animationControllerMyVideoProgress.forward();
    } else {
      _animationControllerMyVideoProgress.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _changeShow,
            child: Center(
                child: Selector<
                        VideoShareDataVm,
                        ({
                          VideoPlayerController? videoPlayerController,
                          String? videoState,
                          bool isShowControls
                        })>(
                    selector: (context, vm) => (
                          videoPlayerController: vm.videoPlayerController,
                          videoState: vm.videoState,
                          isShowControls: vm.isShowControls
                        ),
                    builder: (context, data, child) {
                      switch (data.videoState) {
                        case VideoState.buffering:
                        case VideoState.loading:
                          return YoumiLoading();
                        case VideoState.error:
                          return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {
                                try {
                                  await data.videoPlayerController
                                      ?.initialize();
                                } catch (e) {
                                  print('视频初始化失败：$e');
                                  videoShareDataVm
                                      ?.setVideoState(VideoState.error);
                                  return;
                                }
                              },
                              child: Icon(Icons.refresh_rounded));
                      }
                      if (data.isShowControls) {
                        return (MyPausePlayBtn().animate().fadeIn(
                              duration: 500.milliseconds,
                              curve: Curves.easeInOut,
                            ));
                      }
                      return SizedBox.shrink();
                    }))),
        // 底层的进度条
        Positioned(
                bottom: -20.h, // 为了让进度条显示在屏幕下方，这里设置为 -20，这样进度条就会显示在屏幕下方
                left: 20,
                right: 20,
                child: MyVideoProgress())
            .animate(controller: _animationControllerMyVideoProgress)
            .move(
              begin: const Offset(0, 0), // 起始位置
              end: const Offset(0, -40), // 结束位置
              duration: 500.milliseconds,
              curve: Curves.easeInOut,
            ),
        Selector<VideoShareDataVm, bool>(
            selector: (context, vm) => vm.isShowControls,
            builder: (context, isShowControls, child) {
              return isShowControls
                  ? Positioned(
                          bottom:
                              150.h, // 为了让进度条显示在屏幕下方，这里设置为 -20，这样进度条就会显示在屏幕下方
                          right: 12.w,
                          child: UserOperate())
                      .animate()
                      .fadeIn(
                        duration: 500.milliseconds,
                        curve: Curves.easeInOut,
                      )
                  : SizedBox.shrink();
            }),

        Selector<VideoShareDataVm, bool>(
            selector: (context, vm) => vm.isShowControls,
            builder: (context, isShowControls, child) {
              return isShowControls
                  ? Positioned(
                          bottom:
                              60.h, // 为了让进度条显示在屏幕下方，这里设置为 -20，这样进度条就会显示在屏幕下方
                          left: 12.w,
                          child: VideoInfo())
                      .animate()
                      .fadeIn(
                        duration: 500.milliseconds,
                        curve: Curves.easeInOut,
                      )
                  : SizedBox.shrink();
            }),
      ],
    );
  }
}
