import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youmi/common_ui/video_player/types/video_item_info_t.dart';
import 'package:youmi/common_ui/video_player/video_share_data_vm.dart';

class VideoInfo extends StatefulWidget {
  const VideoInfo({super.key});

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // height: 220.h,
        width: 350.w,
        child: Selector<
                VideoShareDataVm,
                ({
                  VideoItemInfoT? videoItemInfoT,
                  Widget? opBtn,
                })>(
            selector: (context, vm) => (
                  videoItemInfoT: vm.videoItemInfoT,
                  opBtn: vm.opBtn,
                ),
            builder: (context, data, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.videoItemInfoT?.dramaName ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  SizedBox(
                    width: 280.w,
                    child: Text(
                      data.videoItemInfoT?.desc ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  data.opBtn != null
                      ? Container(
                          width: double.infinity,
                          height: 30.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.w),
                            color: Color(0x99000000),
                          ),
                          child: Center(child: data.opBtn),
                        )
                      : SizedBox.shrink()
                ],
              );
            }));
  }
}
