import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youmi/common_ui/my_pop_scope/my_pop_scope.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/pages/favorites/op_page/collectList_page.dart';
import 'package:youmi/pages/favorites/op_page/like_page.dart';
import 'package:youmi/pages/favorites/op_vm.dart';
import 'package:youmi/repository/models/op_action_list/action_datum.dart';
import 'package:youmi/route/route_utils.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  OpVm opVm = OpVm();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)?.settings.arguments;
    List<ActionDatum> likeList = [];
    List<ActionDatum> collectList = [];
    if (map is Map) {
      likeList = map['likeList'];
      collectList = map['collectList'];
    }
    return MyPopScope(
        canBack: (bool isLeading, Object? result) {
          return !isLeading;
        },
        onBack: (BuildContext context) {
          RouteUtils.popOfData<Map<String, List<ActionDatum>>>(context, data: {
            'likeList': opVm.likeList,
            'collectList': opVm.collectList
          });
        },
        child: Scaffold(
            backgroundColor: const Color(0xFF1D1D27),
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () {
                    RouteUtils.popOfData<Map<String, List<ActionDatum>>>(
                        context,
                        data: {
                          'likeList': opVm.likeList,
                          'collectList': opVm.collectList
                        });
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  )),
              backgroundColor: const Color(0xFF1D1D27),
              centerTitle: true,
              title: Hero(
                  tag: 'page-title-${S.of(context).favorites}',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      S.of(context).favorites,
                      overflow: TextOverflow.visible, // 允许溢出
                      softWrap: false,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                      ),
                    ),
                  )),
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
                            // height: 10.sp,
                            child: Center(
                              child: Text(
                                S.of(context).like,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: SizedBox(
                            // height: 10.sp,
                            child: Center(
                              child: Text(
                                S.of(context).collect,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            body: SafeArea(
                child: ChangeNotifierProvider(
                    create: (context) {
                      return opVm;
                    },
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        LikePage(likeList: likeList),
                        CollectListPage(collectList: collectList)
                      ],
                    )))));
  }

  @override
  void dispose() {
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
