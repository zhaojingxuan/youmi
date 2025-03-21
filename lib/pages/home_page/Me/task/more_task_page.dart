import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/pages/home_page/Me/me_vm.dart';
import 'package:youmi/pages/home_page/Me/task/task_list/task_list_item.dart';
import 'package:youmi/repository/models/vip_task_list/task_item.dart';
import 'package:youmi/repository/models/vip_task_list/vip_task_list.dart';
import 'package:youmi/route/route_utils.dart';

class MoreTaskPage extends StatefulWidget {
  const MoreTaskPage({super.key});

  @override
  State<MoreTaskPage> createState() => _MoreTaskPageState();
}

class _MoreTaskPageState extends State<MoreTaskPage> {
  MeVm meVm = MeVm();
  String pageTitle = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((st) async {
      await meVm.getVipTaskList();
      if (!mounted) return;
    });
  }

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)?.settings.arguments;
    if (map is Map) {
      pageTitle = map['pageTitle'] ?? "";
    }
    return ChangeNotifierProvider(
        create: (context) {
          return meVm;
        },
        child: Scaffold(
            backgroundColor: const Color(0xFF1D1D27),
            appBar: AppBar(
                leading: GestureDetector(
                    onTap: () {
                      RouteUtils.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                    )),
                backgroundColor: const Color(0xFF1D1D27),
                centerTitle: true,
                title: Hero(
                  tag:
                      'page-title-${(ModalRoute.of(context)?.settings.arguments as Map?)?["type"]}',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      pageTitle,
                      overflow: TextOverflow.visible, // 允许溢出
                      softWrap: false,
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                  ),
                )),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: DefaultTextStyle(
                      style: TextStyle(color: Colors.white),
                      child: Selector<MeVm, VipTaskList?>(
                        selector: (context, vm) => vm.vipTaskList,
                        builder: (context, vipTaskList, child) {
                          debugPrint("vipTaskList: $vipTaskList");
                          List<TaskItem> taskItemList = [];
                          if (map is Map && vipTaskList != null) {
                            switch (map['type']) {
                              case "dayList":
                                taskItemList = vipTaskList.dayList!;
                                break;
                              case "toDoList":
                                taskItemList = vipTaskList.toDoList!;
                                break;
                              default:
                            }
                          }
                          if (map is Map && taskItemList.isEmpty) {
                            taskItemList = map['taskItemList'] ?? [];
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < taskItemList.length; i++)
                                TaskListItem(item: taskItemList[i], index: i),
                            ],
                          );
                        },
                      ))),
            )));
  }
}
