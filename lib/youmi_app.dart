import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/global/global_info.dart';
import 'package:youmi/global_vm.dart';
import 'package:youmi/route/route_utils.dart';
import 'package:youmi/route/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:youmi/utils/sp_key_constants.dart';
import 'package:youmi/utils/sp_utils.dart';

/// 设计尺寸
Size get designSize {
  final firstView = WidgetsBinding.instance.platformDispatcher.views.first;
  // 逻辑短边
  final logicalShortestSide =
      firstView.physicalSize.shortestSide / firstView.devicePixelRatio;
  // 逻辑长边
  final logicalLongestSide =
      firstView.physicalSize.longestSide / firstView.devicePixelRatio;
  // 缩放比例 designSize越小，元素越大
  const scaleFactor = 2;
  // 缩放后的逻辑短边和长边
  return Size(
      logicalShortestSide * scaleFactor, logicalLongestSide * scaleFactor);
}

// 模拟异步获取数据的函数
Future<String> fetchAppLanguageCode() async {
  String sysLanguageCode =
      WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  String localeLanguageCode =
      (await SpUtils.getString(SPKEYConstants.SP_LanguageCode)) ?? '';
  String useLanguageCode = GlobalInfo.info.canUseLanguageListCode[0];
  if (GlobalInfo.info.canUseLanguageListCode.contains(localeLanguageCode)) {
    useLanguageCode = localeLanguageCode;
  } else if (GlobalInfo.info.canUseLanguageListCode.contains(sysLanguageCode)) {
    useLanguageCode = sysLanguageCode;
  }
  GlobalInfo.info.setLanguageCode(useLanguageCode);
  return useLanguageCode;
}

class YoumiApp extends StatelessWidget {
  const YoumiApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: fetchAppLanguageCode(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 数据还在加载中，显示加载指示器
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            debugPrint('snapshot.error: ${snapshot.error}');
            // 数据加载出错，显示错误信息
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              ),
            );
          } else {
            // 数据加载成功，使用获取到的数据构建 MaterialApp
            return OKToast(
                child: ScreenUtilInit(
              // designSize: designSize,
              designSize: Size(375, 812),
              builder: (context, child) {
                return ChangeNotifierProvider(
                    create: (context) {
                      return GlobalVm();
                    },
                    child: MaterialApp(
                      title: '柚米短剧',
                      theme: ThemeData(
                        colorScheme:
                            ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                        useMaterial3: true,
                        fontFamily: 'Montserrat',
                      ),
                      // 来实现动态路由生成
                      onGenerateRoute: Routes.generateRoute,
                      // 首页路径（初始路由）
                      initialRoute: RoutePath.youmistart,
                      // 导航键
                      navigatorKey: RouteUtils.navigatorKey,
                      // 注册观察者
                      navigatorObservers: [RouteUtils.routeObserver],

                      // 国际化
                      localizationsDelegates: const [
                        S.delegate,
                        GlobalMaterialLocalizations.delegate, // 内置组件本地化（如日期选择器）
                        GlobalWidgetsLocalizations.delegate, // 文本方向支持
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: [
                        for (int i = 0;
                            i < GlobalInfo.info.canUseLanguageListCode.length;
                            i++)
                          Locale(GlobalInfo.info.canUseLanguageListCode[i])
                      ],
                      locale: Locale(snapshot.data!),
                    ));
              },
            ));
          }
        });
  }
}
