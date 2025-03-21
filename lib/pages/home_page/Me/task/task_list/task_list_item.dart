import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youmi/common_ui/my_dialog/my_dialog.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/global_vm.dart';
import 'package:youmi/pages/home_page/Me/me_vm.dart';
import 'package:youmi/pages/home_page/Me/task/task_list/email_input.dart';
import 'package:youmi/pages/home_page/Me/task/task_list/task_progress_bar.dart';
import 'package:youmi/pages/home_page/home_tab_share_data_vm.dart';
import 'package:youmi/repository/api.dart';
import 'package:youmi/repository/models/vip_task_list/task_item.dart';
import 'package:youmi/repository/models/vip_task_list/task_list.dart';
import 'package:youmi/route/route_utils.dart';
import 'package:youmi/route/routes.dart';

class TaskListItem extends StatefulWidget {
  final TaskItem item;
  final int index;

  const TaskListItem({super.key, required this.item, required this.index});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  int get index => widget.index;
  TaskItem get item => widget.item;

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var decoration = BoxDecoration(
      color: const Color.fromRGBO(29, 29, 39, 1), // 背景颜色
      borderRadius: BorderRadius.circular(8.w),
      border: Border.all(
        color: const Color.fromRGBO(47, 47, 59, 1), // 边框颜色
        width: 1, // 边框宽度
      ),
    );
    var decorationGet = BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFB90355),
          Color(0xFF530126),
        ],
        stops: [0.0, 1.0],
      ),
      border: Border.all(
        color: const Color(0xFFFF2D6F),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(8.w),
    );
    return Hero(
      tag: 'TaskListItem_${item.id}',
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.white, decoration: TextDecoration.none),
        child: Container(
          margin: index != 0 ? EdgeInsets.only(top: 16.w) : null,
          padding: EdgeInsets.all(8.w),
          decoration: item.states != 1 ? decoration : decorationGet,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200.w,
                        child: Text(
                          item.taskName ?? '',
                          style: TextStyle(fontSize: 18.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (int i = 0; i < item.list!.length; i++)
                            _subItem(item.list![i])
                        ],
                      )
                    ],
                  ),
                  _getBtnText(item),
                ],
              ),
              SizedBox(
                height: 10.w,
              ),
              TaskProgressBar(item: item)
            ],
          ),
        ),
      ),
    );
  }

  void _doTaskActivity1() {
    showMyDialog(context,
        title: "Email", content: EmailInput(emailController: _emailController),
        surefunc: () async {
      String email = _emailController.text;
      if (EmailValidator.validate(email)) {
        if (await Api.instance.userBingEmail(id: item.id!, email: email)) {
          setState(() {
            item.states = 1;
            item.number = item.taskNumber;
          });
          RouteUtils.pop(context);
        }
      }
    });
  }

  void _doTaskActivity2() async {
    var shareResult = false;
    try {
      final result = await Share.share("share text");
      if (result.status == ShareResultStatus.success) {
        // print('分享成功');
        shareResult = await Api.instance.userShare(id: item.id.toString());
      } else if (result.status == ShareResultStatus.dismissed) {
        // print('用户取消分享');
      }
    } catch (e) {
      // print('分享失败: $e');
    }
    if (shareResult) {
      setState(() {
        item.states = 1;
        item.number = item.taskNumber;
      });
    }
  }

  void _doTaskActivity3() async {
    switch (ModalRoute.of(context)?.settings.name) {
      case RoutePath.moreTask:
        RouteUtils.popOfData<String>(context, data: 'to_tab_1');
        break;
      case RoutePath.youmitab:
        Provider.of<HomeTabShareDataVm>(context, listen: false)
            .setShowTabIndex(1);
        break;
      default:
    }
  }

  void _doTaskActivity6() async {
    var result = false;
    // 检查通知权限状态
    PermissionStatus status = await Permission.notification.status;
    if (status.isDenied) {
      // 请求通知权限
      Map<Permission, PermissionStatus> statuses = await [
        Permission.notification,
      ].request();
      if (statuses[Permission.notification]!.isGranted) {
        print('通知权限已授予');
        result = true;
      } else {
        print('通知权限被拒绝');
        await openAppSettings();
      }
    } else if (status.isGranted) {
      print('通知权限已经授予');
      result = true;
    }
    if (result && await Api.instance.userSingleUp(id: item.id!)) {
      setState(() {
        item.states = 1;
        item.number = item.taskNumber;
      });
    }
  }

  Widget _getBtn({required Widget child}) {
    return Container(
      alignment: Alignment.center,
      width: 80.w,
      height: 32.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.w),
        image: DecorationImage(
          image: AssetImage(item.states != 1
              ? 'assets/images/btn-bg.png'
              : 'assets/images/get-btn.png'), // Use an image from assets
          fit: BoxFit.cover, // Adjusts how the image fits within the container
        ),
      ),
      child: child,
    );
  }

  Widget _getBtnText(TaskItem item) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          // 已完成
          if (item.states == 1) {
            await Api.instance.userTaskAward(taskId: item.id.toString());
            Provider.of<MeVm>(context, listen: false).getVipTaskList();
            Provider.of<GlobalVm>(context, listen: false).updateUserInfo();
            return;
          }
          // 活动的标识 1.绑定邮箱 2.分享 3.每日观看 4.每日首冲 5.每日首次解锁 6开启系统通知  7,看广告
          return switch (item.taskActivity) {
            1 => _doTaskActivity1(),
            2 => _doTaskActivity2(),
            3 => _doTaskActivity3(),
            6 => _doTaskActivity6(),
            _ => showToast("Coming soon!")
          };
        },
        child: _getBtn(
            child: item.states == 1 // 已完成
                ? Text(
                    S.of(context).clip_get,
                    style: TextStyle(
                        fontSize: 14.w,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(29, 29, 39, 1)),
                  )
                : (item.taskActivity == 2
                    ? Image.asset(
                        "assets/images/share_btn.png",
                        width: 18.w,
                      )
                    : Text(
                        S.of(context).go,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ))));
  }
}

Widget _subItem(TaskList subItem) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CachedNetworkImage(
        imageUrl: subItem.image ?? '',
        width: 22.w,
      ),
      Padding(
        padding: EdgeInsets.only(left: 6.w, right: 16.w),
        child:
            Text("+${subItem.number ?? ''}", style: TextStyle(fontSize: 14.sp)),
      )
    ],
  );
}
