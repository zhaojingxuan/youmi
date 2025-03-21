import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HandleVideoPlayerScreen {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  VoidCallback? listenerOver;
  Function(int, String)? dramaUnLockOver;

  HandleVideoPlayerScreen({
    this.videoPlayerController,
    this.chewieController,
    this.listenerOver,
    this.dramaUnLockOver,
  });
}
