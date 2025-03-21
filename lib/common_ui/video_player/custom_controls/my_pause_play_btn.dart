import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:youmi/common_ui/video_player/custom_controls/my_pause_btn.dart';
import 'package:youmi/common_ui/video_player/video_share_data_vm.dart';
import 'package:youmi/common_ui/video_player/types/video_state.dart';
import 'package:youmi/common_ui/youmi_loading/youmi_loading.dart';

class MyPausePlayBtn extends StatefulWidget {
  const MyPausePlayBtn({
    super.key,
  });

  @override
  State<MyPausePlayBtn> createState() => _PausePlayBtnState();
}

class _PausePlayBtnState extends State<MyPausePlayBtn> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<
            VideoShareDataVm,
            ({
              VideoPlayerController? videoPlayerController,
              String? videoState,
            })>(
        selector: (context, vm) => (
              videoPlayerController: vm.videoPlayerController,
              videoState: vm.videoState,
            ),
        builder: (context, data, child) {
          return data.videoState == VideoState.buffering
              ? YoumiLoading()
              : IconButton(
                  icon: data.videoState == VideoState.playing
                      ? MyPauseBtn()
                      : Icon(
                          Icons.play_circle_filled,
                          size: 50,
                          color: Colors.white,
                        ),
                  onPressed: () {
                    // 切换播放/暂停状态
                    if (data.videoState == VideoState.playing) {
                      data.videoPlayerController?.pause();
                    } else {
                      data.videoPlayerController?.play();
                    }
                  },
                );
        });
  }
}
