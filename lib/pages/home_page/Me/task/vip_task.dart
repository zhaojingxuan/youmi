import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/pages/home_page/Me/me_vm.dart';
import 'package:youmi/pages/home_page/Me/task/task_list/task_list_box.dart';
import 'package:youmi/repository/models/vip_task_list/vip_task_list.dart';
import 'package:youmi/route/route_utils.dart';

class VipTask extends StatefulWidget {
  const VipTask({super.key});

  @override
  State<VipTask> createState() => _VipTaskState();
}

class _VipTaskState extends State<VipTask> with RouteAware {
  late MeVm meVm;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    meVm = Provider.of<MeVm>(context, listen: false);
    meVm.getVipTaskList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 订阅 RouteObserver
    RouteUtils.routeObserver
        .subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    // 取消订阅
    RouteUtils.routeObserver.unsubscribe(this);
    // TODO: implement dispose
    super.dispose();
  }

  // 页面被推入栈顶（显示）
  @override
  void didPush() {
    print("页面被推入栈顶，显示");
  }

  // 页面被弹出（隐藏）
  @override
  void didPop() {
    print("页面被弹出，隐藏");
  }

  // 页面从隐藏变为显示（例如上一个页面被弹出）
  @override
  void didPopNext() {
    print("页面从隐藏变为显示");
    meVm.getVipTaskList();
  }

  // 页面被其他页面覆盖（隐藏）
  @override
  void didPushNext() {
    print("页面被其他页面覆盖，隐藏");
  }

  @override
  Widget build(BuildContext context) {
    return Selector<MeVm, VipTaskList?>(
        selector: (context, vm) => vm.vipTaskList,
        builder: (context, vipTaskList, child) {
          return vipTaskList != null
              ? DefaultTextStyle(
                  style: TextStyle(color: Colors.white),
                  child: Column(
                    children: [
                      vipTaskList.dayList?.isNotEmpty ?? false
                          ? TaskListBox(
                              taskItemList: vipTaskList!.dayList!,
                              title: S.of(context).daily_task,
                              type: 'dayList',
                            )
                          : SizedBox.shrink(),
                      vipTaskList.toDoList?.isNotEmpty ?? false
                          ? TaskListBox(
                              taskItemList: vipTaskList.toDoList!,
                              title: (S.of(context).to_do_list),
                              type: 'toDoList',
                            )
                          : SizedBox.shrink(),
                      vipTaskList?.share != null
                          ? TaskListBox(
                              taskItemList: [vipTaskList.share!],
                              title: vipTaskList.share!.taskName!,
                              type: 'share',
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                )
              : SizedBox.shrink();
        });
  }
}
