import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:youmi/common_ui/video_player/video_share_data_vm.dart';

class MyVideoProgress extends StatefulWidget {
  final bool showDuration;

  const MyVideoProgress({super.key, this.showDuration = false});

  @override
  State<MyVideoProgress> createState() => _MyVideoProgresstState();
}

class _MyVideoProgresstState extends State<MyVideoProgress> {
  String position = '00:00';
  String duration = '00:00';

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
    return Selector<VideoShareDataVm, VideoPlayerController?>(
        selector: (context, vm) => vm.videoPlayerController,
        builder: (context, videoPlayerController, child) {
          return Column(
            children: [
              VideoProgressIndicator(
                videoPlayerController!,
                allowScrubbing: true, // 允许用户拖动进度条
                padding: EdgeInsets.zero,
                colors: VideoProgressColors(
                  playedColor: Theme.of(context).primaryColor,
                  bufferedColor: Colors.grey,
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          );
        });
  }
}
