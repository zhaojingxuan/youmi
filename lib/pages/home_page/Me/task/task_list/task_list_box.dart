import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/pages/home_page/Me/task/task_list/task_list_item.dart';
import 'package:youmi/pages/home_page/home_tab_share_data_vm.dart';
import 'package:youmi/repository/models/vip_task_list/task_item.dart';
import 'package:youmi/route/route_utils.dart';
import 'package:youmi/route/routes.dart';

class TaskListBox extends StatefulWidget {
  final List<TaskItem> taskItemList;
  final String title;
  final String? type;

  const TaskListBox(
      {super.key, required this.taskItemList, required this.title, this.type});

  @override
  State<TaskListBox> createState() => _TaskListBoxState();
}

class _TaskListBoxState extends State<TaskListBox> {
  List<TaskItem> get taskItemList => widget.taskItemList;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 343.w,
        margin: EdgeInsets.only(top: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0.w),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x6F2B2B36), // rgba(43, 43, 54, 0.81)
              Color(0x8A2B2B36), // rgba(43, 43, 54, 0.54)
            ],
          ),
          border: Border.all(
            color: Color(0xFF2B2B36), // rgba(43, 43, 54, 1)
            width: 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000), // rgba(0, 0, 0, 0.2)
              blurRadius: 6,
              offset: Offset(0, 6), // 阴影偏移量
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 10.w),
                child: Hero(
                    tag: 'page-title-${widget.type}',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(widget.title,
                          overflow: TextOverflow.visible, // 允许溢出
                          softWrap: false,
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white)),
                    ))),
            for (int i = 0; i < min(2, taskItemList.length); i++)
              TaskListItem(item: taskItemList[i], index: i),
            if (taskItemList.length > 2) _more(),
          ],
        ));
  }

  Widget _more() {
    return Container(
      margin: EdgeInsets.only(top: 16.w),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(29, 29, 39, 1), // 背景颜色
        borderRadius: BorderRadius.circular(8.w),
        border: Border.all(
          color: const Color.fromRGBO(47, 47, 59, 1), // 边框颜色
          width: 1, // 边框宽度
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).earn_more_rewards,
                  style: TextStyle(fontSize: 18.sp)),
              SizedBox(
                height: 10.w,
              ),
              Image.asset(
                'assets/images/jinbi.png',
                width: 22.w,
                height: 22.w,
              ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              var res = await RouteUtils.pushForNamed(
                  context, RoutePath.moreTask, arguments: {
                "type": widget.type,
                "taskItemList": taskItemList,
                "pageTitle": widget.title
              });
              switch (res) {
                case 'to_tab_1':
                  Provider.of<HomeTabShareDataVm>(context, listen: false)
                      .setShowTabIndex(1);
                  break;
                default:
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: 80.w,
              height: 32.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/btn-bg.png'), // Use an image from assets
                  fit: BoxFit
                      .cover, // Adjusts how the image fits within the container
                ),
              ),
              child: Text(
                S.of(context).clip_more,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
