import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/pages/setting_page/doc/PrivacyPolicy.dart';
import 'package:youmi/pages/setting_page/doc/ServiceTerms.dart';
import 'package:youmi/route/route_utils.dart';

class SettingAbout extends StatefulWidget {
  const SettingAbout({super.key});

  @override
  State<SettingAbout> createState() => _SettingAboutState();
}

class _SettingAboutState extends State<SettingAbout>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget w4h = Material(
      color: Colors.transparent,
      child: Text(S.of(context).about,
          overflow: TextOverflow.visible, // 允许溢出
          softWrap: false, // 禁用自动换行
          style: TextStyle(color: Colors.white, fontSize: 20.sp)),
    );
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
        title: Hero(
          tag: 'setting_page${S.of(context).about}',
          child: w4h,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(44.w), // 指定 TabBar 高度
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.w), // 圆角 16px
                // 设置边框
                border: Border.all(
                  // 转换 rgba(47, 47, 59, 1) 为 Flutter 颜色
                  color: const Color.fromRGBO(47, 47, 59, 1),
                  // 设置边框宽度为 1 像素
                  width: 1,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Color.fromRGBO(
                  172,
                  174,
                  187,
                  1,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: Color(0xFF2F2F3B),
                  borderRadius: BorderRadius.circular(50.w),
                ),
                tabs: [
                  Tab(
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          'PrivacyPolicy',
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          'ServiceTerms',
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
      body: SafeArea(
          child: Container(
              margin: EdgeInsets.only(top: 16.w),
              padding: EdgeInsets.only(bottom: 10.w),
              child: DefaultTextStyle(
                  style: TextStyle(
                      color: Colors.white, fontSize: 16.sp, height: 1.4),
                  child: TabBarView(
                    controller: _tabController,
                    // physics: NeverScrollableScrollPhysics(), // 禁止滑动切换
                    children: [
                      // 第一个标签内容
                      ListView.builder(
                        itemCount: docPrivacyPolicy.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w, right: 20.w, bottom: 12.w),
                              child: Text(docPrivacyPolicy[index]));
                        },
                      ),
                      // 第二个标签内容
                      ListView.builder(
                        itemCount: docServiceTerms.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w, right: 20.w, bottom: 12.w),
                              child: Text(docServiceTerms[index]));
                        },
                      ),
                    ],
                  )))),
    );
  }
}
