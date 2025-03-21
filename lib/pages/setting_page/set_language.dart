import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/global/global_info.dart';
import 'package:youmi/route/route_utils.dart';

class SetLanguage extends StatefulWidget {
  const SetLanguage({super.key});

  @override
  State<SetLanguage> createState() => _SetLanguageState();
}

class _SetLanguageState extends State<SetLanguage> {
  List<_ItemsType> items = [
    for (int i = 0; i < GlobalInfo.info.showUseLanguageListLabel.length; i++)
      _ItemsType(title: GlobalInfo.info.showUseLanguageListLabel[i]),
  ];

  @override
  Widget build(BuildContext context) {
    Widget w4h = Material(
        color: Colors.transparent,
        child: Text(
          S.of(context).language,
          overflow: TextOverflow.visible, // 允许溢出
          softWrap: false, // 禁用自动换行
          style: TextStyle(color: Colors.white, fontSize: 20.sp),
        ));
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
            tag: 'setting_page${S.of(context).language}',
            child: w4h,
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
    return GestureDetector(
        onTap: () async {
          for (int i = 0; i < GlobalInfo.info.canUseLanguageList.length; i++) {
            if (GlobalInfo.info.canUseLanguageList[i].values
                .toList()
                .contains(item.title)) {
              await GlobalInfo.info.setLanguageCode(
                  GlobalInfo.info.canUseLanguageList[i].keys.toList()[0]);
              S.load(Locale(GlobalInfo.info.getLanguageCode()));
              WidgetsBinding.instance.performReassemble();
            }
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
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  GlobalInfo.info.nowLanguage.values
                          .toList()
                          .contains(item.title)
                      ? Image.asset(
                          'assets/images/select.png',
                          width: 32.w,
                        )
                      : Image.asset(
                          'assets/images/unselect.png',
                          width: 32.w,
                        )
                ],
              ),
            )));
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isSwitched,
      onChanged: (bool newValue) {
        setState(() {
          _isSwitched = newValue;
        });
      },
    );
  }
}

class _ItemsType {
  final String title;
  const _ItemsType({
    required this.title,
  });
}
