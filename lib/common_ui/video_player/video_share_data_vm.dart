import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youmi/common_ui/video_player/types/video_item_info_t.dart';
import 'package:youmi/common_ui/video_player/types/video_state.dart';
import 'package:youmi/repository/api.dart';
import 'package:youmi/repository/models/index_sale/item_sale.dart';

class VideoShareDataVm with ChangeNotifier {
  bool _isShowControls = true;
  bool get isShowControls => _isShowControls;

  VideoItemInfoT? _videoItemInfoT;
  VideoItemInfoT? get videoItemInfoT => _videoItemInfoT;

  String? _videoState = VideoState.loading;
  String? get videoState => _videoState;

  VideoPlayerController? _videoPlayerController;
  VideoPlayerController? get videoPlayerController => _videoPlayerController;

  Widget? _opBtn = SizedBox.shrink();
  Widget? get opBtn => _opBtn;

  void changeOpBtn(op) {
    _opBtn = op;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void changeShow() {
    _isShowControls = !_isShowControls;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void setIsShowControls(bool v) {
    _isShowControls = v;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void setVideoItemInfoT(VideoItemInfoT videoItemInfoT) {
    _videoItemInfoT = videoItemInfoT;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void setVideoState(String state) {
    _videoState = state;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void setVideoPlayerController(VideoPlayerController controller) {
    _videoPlayerController = controller;
    if (hasListeners) {
      notifyListeners();
    }
  }

  Future createUserShow({
    required int dramaId,
    required int epId,
    required String playTime,
    required String playDuration,
  }) async {
    await Api.instance.createUserShow(
        dramaId: dramaId,
        epId: epId,
        playTime: playTime,
        playDuration: playDuration);
  }

  Future userOpActionSet(
    int type,
    int action,
  ) async {
    if (videoPlayerController?.value.isPlaying == true) {
      startDelayedTask();
    }
    int like = _videoItemInfoT?.like ?? 0;
    int likeNumber = _videoItemInfoT?.likeNumber ?? 0;
    int collect = _videoItemInfoT?.collect ?? 0;
    int collectNumber = _videoItemInfoT?.collectNumber ?? 0;
    switch (type) {
      case 0:
        if (action == 0) {
          like = 1;
          likeNumber = likeNumber + 1;
        } else {
          like = 0;
          likeNumber = max(likeNumber - 1, 0);
        }
        break;
      case 1:
        if (action == 0) {
          collect = 1;
          collectNumber = collectNumber + 1;
        } else {
          collect = 0;
          collectNumber = max(collectNumber - 1, 0);
        }
        break;
      default:
        break;
    }
    setVideoItemInfoT(_videoItemInfoT!.copyWith(
        like: like,
        likeNumber: likeNumber,
        collect: collect,
        collectNumber: collectNumber));

    if (!await Api.instance.userOpActionSet(
        ItemSale(dramaId: videoItemInfoT?.dramaId, epId: videoItemInfoT?.epId),
        type,
        action)) {
      print("操作失败");
      switch (type) {
        case 0:
          if (action == 1) {
            like = 1;
            likeNumber = (_videoItemInfoT?.likeNumber ?? 0) + 1;
          } else {
            like = 0;
            likeNumber = max((_videoItemInfoT?.likeNumber ?? 0) - 1, 0);
          }
          break;
        case 1:
          if (action == 1) {
            collect = 1;
            collectNumber = (_videoItemInfoT?.collectNumber ?? 0) + 1;
          } else {
            collect = 0;
            collectNumber = max((_videoItemInfoT?.collectNumber ?? 0) - 1, 0);
          }
          break;
        default:
          break;
      }
      setVideoItemInfoT(_videoItemInfoT!.copyWith(
          like: like,
          likeNumber: likeNumber,
          collect: collect,
          collectNumber: collectNumber));
    }
  }

  StreamSubscription? _cancelableOperation;

  // 启动延迟任务
  void startDelayedTask() {
    // 取消任何正在进行的任务
    _cancelableOperation?.cancel();

    // 创建新的可取消操作
    _cancelableOperation =
        (Future.delayed(Duration(seconds: 5))).asStream().listen((_) {
      setIsShowControls(false);
    });
  }

  // 取消延迟任务
  void cancelDelayedTask() {
    _cancelableOperation?.cancel();
  }
}
