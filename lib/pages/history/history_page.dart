import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youmi/common_ui/my_pop_scope/my_pop_scope.dart';
import 'package:youmi/common_ui/youmi_postar/youmi_poster.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/pages/history/history_vm.dart';
import 'package:youmi/repository/models/history_list/history.dart';
import 'package:youmi/route/route_utils.dart';
import 'package:youmi/route/routes.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  HistoryVm historyVm = HistoryVm();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    historyVm.getUserHistory();
  }

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)?.settings.arguments;
    List<History>? h = [];
    if (map is Map) {
      h = map['historyList'];
    }
    return MyPopScope(
        canBack: (bool isLeading, Object? result) {
          return !isLeading;
        },
        onBack: (BuildContext context) {
          RouteUtils.popOfData<List<History>?>(context,
              data: historyVm.historyList);
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF1D1D27),
          appBar: AppBar(
            leading: GestureDetector(
                onTap: () {
                  RouteUtils.popOfData<List<History>?>(context,
                      data: historyVm.historyList);
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                )),
            backgroundColor: const Color(0xFF1D1D27),
            centerTitle: true,
            title: Hero(
                tag: 'page-title-${S.of(context).history}',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    S.of(context).history,
                    overflow: TextOverflow.visible, // 允许溢出
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                )),
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ChangeNotifierProvider(
                create: (context) {
                  return historyVm;
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Selector<HistoryVm, List<History>?>(
                        selector: (context, vm) => vm.historyList,
                        builder: (context, historyList, child) {
                          h = historyList?.isNotEmpty == true ? historyList : h;
                          return Wrap(
                            alignment: WrapAlignment.start,
                            runSpacing: 16.0.w,
                            children: [
                              for (int i = 0; i < (h?.length ?? 0); i++)
                                _item(h?[i], i)
                            ],
                          );
                        }))),
          )),
        ));
  }

  Widget _item(History? actionDatum, int index) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      // 计算宽度为父组件宽度的 30%
      double width = constraints.maxWidth / 3;
      var heroKeyTag = 'likePage_$index';
      return GestureDetector(
          onTap: () {
            RouteUtils.pushForNamed(context, RoutePath.playPage, arguments: {
              "dramaId": actionDatum?.dramaId,
              "picUrl": actionDatum?.dramaImg ?? '',
              "heroKeyTag": heroKeyTag
            });
          },
          child: SizedBox(
              width: width,
              // height: double.infinity,
              child: Center(
                  child: Stack(
                children: [
                  SizedBox(
                      height: 203.w,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            YoumiPoster(
                              heroKeyTag: heroKeyTag,
                              postUrl: actionDatum?.dramaImg ?? '',
                              width: 98.w,
                              height: 140.w,
                            ),
                            SizedBox(
                              height: 4.w,
                            ),
                            Text(
                              actionDatum?.dramaName ?? '',
                              maxLines: 2, // 设置最多显示两行
                              overflow: TextOverflow.ellipsis, // 超出部分用省略号表示
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.white),
                            ),
                            // Expanded(
                            //   child: SizedBox.shrink(),
                            // ),
                          ])),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      child: Text(
                        'EP.${actionDatum?.epSort}',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Color.fromRGBO(172, 174, 187, 1)),
                      ))
                ],
              ))));
    });
  }
}
