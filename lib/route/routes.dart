import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youmi/pages/favorites/favorites_page.dart';
import 'package:youmi/pages/history/history_page.dart';
import 'package:youmi/pages/home_page/Me/task/more_task_page.dart';
import 'package:youmi/pages/play_page/play_page.dart';
import 'package:youmi/pages/home_page/youmi_home_tab_page.dart';
import 'package:youmi/pages/setting_page/set_language.dart';
import 'package:youmi/pages/setting_page/setting_about.dart';
import 'package:youmi/pages/setting_page/setting_page.dart';
import 'package:youmi/pages/start/youmi_start_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // switch (settings.name) {
    //   case RoutePath.youmistart:
    //     return pageRoute(YoumiStartPage(), settings: settings);
    //   case RoutePath.youmitab:
    //     return pageRoute(YoumiHomeTabPage(), settings: settings);
    //   case RoutePath.playPage:
    //     return pageRoute(PlayPage(), settings: settings);
    //   case RoutePath.history:
    //     return pageRoute(HistoryPage(), settings: settings);
    //   case RoutePath.favorites:
    //     return pageRoute(FavoritesPage(), settings: settings);
    //   case RoutePath.setting:
    //     return pageRoute(SettingPage(), settings: settings);
    //   case RoutePath.settingLanguage:
    //     return pageRoute(SetLanguage(), settings: settings);
    //   case RoutePath.settingAbout:
    //     return pageRoute(SettingAbout(), settings: settings);
    //   case RoutePath.moreTask:
    //     return pageRoute(MoreTaskPage(), settings: settings);
    //   default:
    // }

    Widget? page;

    switch (settings.name) {
      case RoutePath.youmistart:
        page = YoumiStartPage();
      case RoutePath.youmitab:
        page = YoumiHomeTabPage();
      case RoutePath.playPage:
        page = PlayPage();
      case RoutePath.history:
        page = HistoryPage();
      case RoutePath.favorites:
        page = FavoritesPage();
      case RoutePath.setting:
        page = SettingPage();
      case RoutePath.settingLanguage:
        page = SetLanguage();
      case RoutePath.settingAbout:
        page = SettingAbout();
      case RoutePath.moreTask:
        page = MoreTaskPage();
      default:
    }

    if (page != null) {
      return PageRouteBuilder(
        transitionDuration: Duration(
            milliseconds:
                settings.name == RoutePath.youmitab ? 500 : 300), // 动画时长
        pageBuilder: (context, animation, secondaryAnimation) => page!,
        settings: settings,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          if (settings.name == RoutePath.playPage) {
            return FadeTransition(
              opacity: animation, // 直接使用动画作为透明度
              child: child,
            );
          }
          // 创建滑动动画
          var begin = const Offset(1.0, 0.0); // 从右往左进入
          if (settings.name == RoutePath.youmitab) {
            begin = const Offset(0.0, 1.0); // 从下往上进入
          }
          var end = Offset.zero;
          var curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          // return SlideTransition(
          //   position: animation.drive(tween),
          //   child: child,
          // );

          return settings.name == RoutePath.youmitab
              ? SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                )
              : CupertinoPageTransition(
                  primaryRouteAnimation: animation,
                  secondaryRouteAnimation: secondaryAnimation,
                  linearTransition: true,
                  child: child,
                );
        },
      );
    }

    return MaterialPageRoute(
        builder: (context) => Scaffold(
            body:
                Center(child: Text('No route defined for ${settings.name}'))));
  }

  static MaterialPageRoute pageRoute(
    Widget page, {
    RouteSettings? settings,
    bool? fullscreenDialog,
    bool? maintainState,
    bool? allowSnapshotting,
  }) {
    return MaterialPageRoute(
        builder: (context) => page,
        settings: settings,
        fullscreenDialog: fullscreenDialog ?? false,
        maintainState: maintainState ?? true,
        allowSnapshotting: allowSnapshotting ?? true);
  }
}

class RoutePath {
  static const String youmistart = "/youmistart";
  static const String youmitab = "/youmitab";
  static const String playPage = "/playPage";
  static const String history = "/history";
  static const String favorites = "/favorites";
  static const String setting = "/setting";
  static const String settingLanguage = "/setting_language";
  static const String settingAbout = "/setting_about";
  static const String moreTask = "/more_task";
}
