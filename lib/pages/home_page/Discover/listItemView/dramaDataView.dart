import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/common_ui/youmi_postar/youmi_poster.dart';
import 'package:youmi/repository/models/drama_data/drama_datum.dart';
import 'package:youmi/route/route_utils.dart';
import 'package:youmi/route/routes.dart';

class DramadataView extends StatelessWidget {
  final List<DramaDatum> datumList;
  const DramadataView({super.key, required this.datumList});

  @override
  Widget build(BuildContext context) {
    return datumList.isNotEmpty
        ? Container(
            width: double.infinity,
            // height: 233.w,
            margin: EdgeInsets.only(left: 12.w, right: 12.w),
            padding: EdgeInsets.all(10.w),
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
              borderRadius: BorderRadius.all(Radius.circular(8.w)),
            ),
            child: Column(children: [
              Row(
                children: [
                  Icon(
                    Icons.bar_chart,
                    color: Color.fromRGBO(255, 232, 176, 1),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Text(
                    (S.of(context).popular_now).trim(),
                    style: TextStyle(color: Color.fromRGBO(255, 232, 176, 1)),
                  )
                ],
              ),
              Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  // spacing: 1.0.w,
                  runSpacing: 10.0.w,
                  children: [
                    for (int i = 0; i < (datumList.length); i++)
                      _moduleListItemView(context, datumList[i], i)
                  ]),
            ]))
        : SizedBox();
  }

  Widget _moduleListItemView(BuildContext context, DramaDatum item, int index) {
    var heroKeyTag = 'dramaDataView_$index';
    return GestureDetector(
        onTap: () {
          RouteUtils.pushForNamed(context, RoutePath.playPage, arguments: {
            "dramaId": item.dramaId,
            "picUrl": item.posterUrl1 ?? '',
            "heroKeyTag": heroKeyTag,
          });
        },
        child: Container(
          width: 98.w,
          margin: EdgeInsets.only(right: 10.w),
          child: Column(children: [
            SizedBox(
              height: 4.w,
            ),
            YoumiPoster(
              heroKeyTag: heroKeyTag,
              postUrl: item.posterUrl1 ?? '',
              width: 98.w,
              height: 140.w,
            ),
            SizedBox(
              height: 4.w,
            ),
            Text(
              item.dramaName ?? '',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ]),
        ));
  }
}
