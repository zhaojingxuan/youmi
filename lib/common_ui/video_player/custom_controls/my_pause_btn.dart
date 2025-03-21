import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youmi/common_ui/video_player/video_share_data_vm.dart';

class MyPauseBtn extends StatefulWidget {
  const MyPauseBtn({super.key});

  @override
  State<MyPauseBtn> createState() => _MyPauseBtnState();
}

class _MyPauseBtnState extends State<MyPauseBtn> {
  VideoShareDataVm? videoShareDataVm;
  @override
  void initState() {
    videoShareDataVm = Provider.of<VideoShareDataVm>(context, listen: false);
    videoShareDataVm?.startDelayedTask();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.pause_circle_filled,
      size: 50,
      color: Colors.white,
    );
  }

  @override
  void dispose() {
    debugPrint('MyPauseBtn dispose');
    videoShareDataVm?.cancelDelayedTask();
    // TODO: implement dispose
    super.dispose();
  }
}
