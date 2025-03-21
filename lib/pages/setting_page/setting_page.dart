import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:youmi/common_ui/my_dialog/my_dialog.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/global/global_info.dart';
import 'package:youmi/pages/setting_page/switch_automatic_release.dart';
import 'package:youmi/route/route_utils.dart';
import 'package:youmi/route/routes.dart';

class _ItemsType {
  final String title;
  final String? subTitle;
  final Widget? right;
  final VoidCallback? action;
  const _ItemsType({
    required this.title,
    this.subTitle,
    this.right,
    this.action,
  });
}

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<_ItemsType> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((st) {
      items = [
        _ItemsType(
            title: S.of(context).help_and_feedback,
            action: () => showToast('Coming soon!')),
        // _ItemsType(title: S.of(context).affiliation),
        _ItemsType(
            title: S.of(context).about,
            action: () => RouteUtils.pushForNamed(
                  context,
                  RoutePath.settingAbout,
                )),
        _ItemsType(
            title: S.of(context).language,
            subTitle: RegExp(r'\((.*?)\)')
                .firstMatch(GlobalInfo.info.nowLanguage.values.toList()[0])
                ?.group(1),
            action: () => RouteUtils.pushForNamed(
                  context,
                  RoutePath.settingLanguage,
                )),
        _ItemsType(
            title: S.of(context).automatic_release,
            right: SwitchAutomaticRelease()),
        _ItemsType(
            title: S.of(context).account_cancellation,
            right: SizedBox.shrink(),
            action: () => showMyDialog(context,
                title: S.of(context).tips,
                content: Text(S.of(context).delete_account_tips,
                    style: TextStyle(color: Colors.white70)),
                showCancelbtn: false)),
        _ItemsType(
            title: S.of(context).log_out,
            right: SizedBox.shrink(),
            action: () => showMyDialog(
                  context,
                  title: S.of(context).tips,
                  content: Text(S.of(context).sure_to_log_out,
                      style: TextStyle(color: Colors.white70)),
                  surefunc: () {
                    RouteUtils.pop(context);
                    RouteUtils.pop(context);
                  },
                )),
      ];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Text(
            S.of(context).settings,
            style: TextStyle(color: Colors.white, fontSize: 20.sp),
          ),
        ),
        body: SafeArea(
          child: ListView.builder(
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(child: _listItemView(items[index]));
            },
          ),
        ));
  }

  Widget _listItemView(_ItemsType item) {
    Widget w4h = Material(
      color: Colors.transparent,
      child: Text(
        item.title,
        overflow: TextOverflow.visible, // 允许溢出
        softWrap: false, // 禁用自动换行
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
    );
    return GestureDetector(
        onTap: () {
          if (item.action != null) {
            item.action!();
          }
        },
        child: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: Container(
              width: 343.w,
              height: 50.w,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              margin: EdgeInsets.only(bottom: 16.w),
              decoration: BoxDecoration(
                // 线性渐变背景
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(43, 43, 54, 0.81),
                    Color.fromRGBO(43, 43, 54, 0.54),
                  ],
                ),
                // 边框
                border: Border.all(
                  color: const Color.fromRGBO(43, 43, 54, 1),
                  width: 1.w,
                ),
                // 盒子阴影
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(0, 0, 0, 0.2),
                    offset: const Offset(0, 6),
                    blurRadius: 6,
                  ),
                ],
                // 圆角效果，对应 border - radius: 8px;
                borderRadius: BorderRadius.circular(8.w),
              ),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hero(
                    tag: 'setting_page${item.title}',
                    child: w4h,
                  ),
                  Row(
                    children: [
                      item.subTitle != null
                          ? Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Text(
                                item.subTitle ?? '',
                                style: TextStyle(fontSize: 16.sp),
                              ))
                          : SizedBox.shrink(),
                      item.right ??
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          ),
                    ],
                  )
                ],
              ),
            )));
  }
}
