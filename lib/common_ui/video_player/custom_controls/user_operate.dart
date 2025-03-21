import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youmi/common_ui/navigation/Animation_click.dart';
import 'package:youmi/common_ui/video_player/types/video_item_info_t.dart';
import 'package:youmi/common_ui/video_player/video_share_data_vm.dart';

class UserOperate extends StatefulWidget {
  const UserOperate({super.key});

  @override
  State<UserOperate> createState() => _UserOperateState();
}

class _UserOperateState extends State<UserOperate> {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<VideoShareDataVm>(context, listen: false);
    return SizedBox(
        height: 220.w,
        child: Selector<VideoShareDataVm, VideoItemInfoT?>(
            selector: (context, vm) => vm.videoItemInfoT,
            shouldRebuild: (prev, next) => prev != next, // 依赖重写的 == 运算符
            builder: (context, videoItemInfoT, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        vm.userOpActionSet(
                            0,
                            (videoItemInfoT?.like == null ||
                                    videoItemInfoT?.like == 0)
                                ? 0
                                : 1);
                      },
                      child: _Item(
                          image: ((videoItemInfoT?.like == null ||
                                  videoItemInfoT?.like == 0)
                              ? AnimationClick(
                                  key: ValueKey('assets/images/nolike.png'),
                                  builder: (context) {
                                    return Image.asset(
                                      'assets/images/nolike.png',
                                      width: 32.w,
                                    );
                                  })
                              : AnimationClick(
                                  key: ValueKey('assets/images/like.png'),
                                  builder: (context) {
                                    return Image.asset(
                                      'assets/images/like.png',
                                      width: 32.w,
                                    );
                                  })),
                          text: videoItemInfoT?.likeNumber.toString() ?? '')),
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        vm.userOpActionSet(
                            1,
                            (videoItemInfoT?.collect == null ||
                                    videoItemInfoT?.collect == 0)
                                ? 0
                                : 1);
                      },
                      child: _Item(
                          image: ((videoItemInfoT?.collect == null ||
                                  videoItemInfoT?.collect == 0)
                              ? AnimationClick(
                                  key: ValueKey('assets/images/nocollect.png'),
                                  builder: (context) {
                                    return Image.asset(
                                      'assets/images/nocollect.png',
                                      width: 32.w,
                                    );
                                  })
                              : AnimationClick(
                                  key: ValueKey('assets/images/collect.png'),
                                  builder: (context) {
                                    return Image.asset(
                                      'assets/images/collect.png',
                                      width: 32.w,
                                    );
                                  })),
                          text:
                              videoItemInfoT?.collectNumber.toString() ?? '')),
                  GestureDetector(
                    onTap: () async {
                      try {
                        final result = await Share.share("share text");
                        if (result.status == ShareResultStatus.success) {
                          print('分享成功');
                        } else if (result.status ==
                            ShareResultStatus.dismissed) {
                          print('用户取消分享');
                        }
                      } catch (e) {
                        print('分享失败: $e');
                      }
                    },
                    child: _Item(
                        image: Image.asset(
                          'assets/images/share.png',
                          width: 32.w,
                        ),
                        text: videoItemInfoT?.forwardNumber.toString() ?? ''),
                  ),
                ],
              );
            }));
  }
}

class _Item extends StatelessWidget {
  final Widget image;
  final String text;
  const _Item({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image,
        SizedBox(
          height: 2.w,
        ),
        Text(text, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
