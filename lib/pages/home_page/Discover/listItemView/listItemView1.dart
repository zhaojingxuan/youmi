import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youmi/common_ui/youmi_postar/youmi_poster.dart';
import 'package:youmi/repository/models/youmi_home_model/module_list_item_model.dart';
import 'package:youmi/repository/models/youmi_home_model/youmi_home_module.dart';
import 'package:youmi/route/route_utils.dart';
import 'package:youmi/route/routes.dart';

class ListitemView1 extends StatelessWidget {
  final YoumiHomeModule? item;
  final String? diffKey;

  const ListitemView1({super.key, this.item, this.diffKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 233.w,
      margin: EdgeInsets.only(bottom: 16.w, left: 12.w),
      padding: EdgeInsets.only(top: 10.w, left: 10.w, bottom: 10.w),
      decoration: BoxDecoration(
        // 使用 LinearGradient 实现线性渐变
        gradient: LinearGradient(
          // 渐变方向，180deg 对应 Flutter 中的 Alignment.topCenter 到 Alignment.bottomCenter
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // 渐变的颜色和位置，对应 CSS 中的 rgba 颜色和百分比
          colors: [
            const Color.fromRGBO(43, 43, 54, 0.81),
            const Color.fromRGBO(43, 43, 54, 0.54),
          ],
          stops: const [0.0, 1.0],
        ),
        border: Border.all(
          // 设置边框的宽度，对应 CSS 中的 1px
          width: 1,
          // 设置边框的颜色，对应 CSS 中的 rgba(43, 43, 54, 1)
          color: const Color.fromRGBO(43, 43, 54, 1),
        ),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.w), bottomLeft: Radius.circular(8.w)),
      ),
      child: Column(children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: item?.icon ?? '',
              width: 12.w,
              height: 12.w,
            ),
            SizedBox(
              width: 6.w,
            ),
            Text(
              (item?.moduleTitle ?? "").trim(),
              style: TextStyle(color: Color.fromRGBO(255, 232, 176, 1)),
            )
          ],
        ),
        SizedBox(
          height: 4.w,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < (item?.list?.length ?? 0); i++)
                _moduleListItemView(context, item?.list?[i], i)
            ],
          ),
        )
      ]),
    );
  }

  Widget _moduleListItemView(
      BuildContext context, ModuleListItemModel? item, int index) {
    var heroKeyTag = 'listItemView1_${index}_$diffKey}';
    return GestureDetector(
        onTap: () {
          RouteUtils.pushForNamed(context, RoutePath.playPage, arguments: {
            "dramaId": item?.dramaId,
            "picUrl": item?.posterUrl1 ?? '',
            "heroKeyTag": heroKeyTag,
          });
        },
        child: Container(
          width: 100.w,
          margin: EdgeInsets.only(right: 10.w),
          child: Column(children: [
            SizedBox(
              height: 4.w,
            ),
            YoumiPoster(
              heroKeyTag: heroKeyTag,
              postUrl: item?.posterUrl1 ?? '',
              width: 100.w,
              height: 140.w,
            ),
            SizedBox(
              height: 4.w,
            ),
            Text(
              item?.dramaName ?? '',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ]),
        ));
  }
}
