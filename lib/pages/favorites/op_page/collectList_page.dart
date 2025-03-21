import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youmi/common_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:youmi/common_ui/youmi_postar/youmi_poster.dart';
import 'package:youmi/pages/favorites/op_vm.dart';
import 'package:youmi/repository/models/op_action_list/action_datum.dart';
import 'package:youmi/route/route_utils.dart';
import 'package:youmi/route/routes.dart';

class CollectListPage extends StatefulWidget {
  final List<ActionDatum> collectList;
  const CollectListPage({super.key, required this.collectList});

  @override
  State<CollectListPage> createState() => _CollectListPageState();
}

class _CollectListPageState extends State<CollectListPage> {
  RefreshController refreshController = RefreshController();

  late OpVm opVm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    opVm = Provider.of<OpVm>(context, listen: false);
    if (opVm.collectList.isEmpty) {
      opVm.getCollectList(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefreshWidget(
        controller: refreshController,
        enablePullDown: true,
        enablePullUp: true,
        header: ClassicHeader(),
        footer: ClassicFooter(),
        onRefresh: () async {
          opVm.getCollectList(false);
          refreshController.refreshCompleted();
          refreshController.loadComplete();
        },
        onLoading: () async {
          // 上拉加载
          if (await opVm.getCollectList(true)) {
            refreshController.loadComplete();
          } else {
            refreshController.loadNoData();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Selector<OpVm, List<ActionDatum>>(
                  selector: (context, vm) => vm.collectList,
                  builder: (context, collectList, child) {
                    List<ActionDatum> list =
                        collectList.isEmpty ? widget.collectList : collectList;
                    return Wrap(
                      alignment: WrapAlignment.start,
                      runSpacing: 16.0.w,
                      children: [
                        for (int i = 0; i < list.length; i++) _item(list[i], i)
                      ],
                    );
                  })),
        ));
  }

  Widget _item(ActionDatum actionDatum, int index) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      // 计算宽度为父组件宽度的 30%
      double width = constraints.maxWidth / 3;
      var heroKeyTag = 'collectListPage_$index';
      return GestureDetector(
          onTap: () {
            RouteUtils.pushForNamed(context, RoutePath.playPage, arguments: {
              "dramaId": actionDatum.dramaId,
              "picUrl": actionDatum.dramaUrl ?? '',
              "heroKeyTag": heroKeyTag,
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
                              postUrl: actionDatum.dramaUrl ?? '',
                              width: 98.w,
                              height: 140.w,
                            ),
                            SizedBox(
                              height: 4.w,
                            ),
                            Text(
                              actionDatum.dramaName ?? '',
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
                        'EP.${actionDatum.epSort}',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Color.fromRGBO(172, 174, 187, 1)),
                      ))
                ],
              ))));
    });
  }
}
