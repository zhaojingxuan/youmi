import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youmi/pages/play_page/audio_wave_animation.dart';
import 'package:youmi/repository/models/drama_list/drama_item.dart';

class DrawerBottom extends StatefulWidget {
  final int currentIndex;
  final List<DramaItem> listDrama;
  final void Function(int) callback;
  const DrawerBottom(
      {super.key,
      required this.currentIndex,
      required this.callback,
      required this.listDrama});

  @override
  State<DrawerBottom> createState() => _DrawerBottomState();
}

class _DrawerBottomState extends State<DrawerBottom>
    with SingleTickerProviderStateMixin {
  List<DramaItem> get listDrama => widget.listDrama;
  late TabController _tabController;
  late int size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    size = (listDrama.length / 30).ceil();
    _tabController = TabController(
        length: size,
        initialIndex: (widget.currentIndex / 30).floor(),
        vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 416.w,
        padding: EdgeInsets.symmetric(vertical: 0.w),
        decoration: BoxDecoration(
          // 设置背景颜色
          color: const Color.fromRGBO(29, 29, 39, 1),
          // 设置阴影
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.2),
              offset: const Offset(0, 6), // 阴影的偏移量
              blurRadius: 6, // 阴影的模糊半径
              spreadRadius: 0, // 阴影的扩展半径
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.w), topRight: Radius.circular(16.w)),
        ),
        child: DefaultTextStyle(
          style: TextStyle(fontSize: 14.sp, color: Colors.white),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Anthology List",
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.clear_rounded,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 3.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: size * 70.w,
                    child: TabBar(
                        controller: _tabController,
                        labelColor: Color.fromRGBO(255, 45, 111, 1),
                        unselectedLabelColor: Colors.white,
                        // indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: Color.fromRGBO(255, 45, 111, 1),
                        tabs: [
                          for (int i = 0;
                              i < (listDrama.length / 30).ceilToDouble();
                              i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                '${i * 30 + 1}-${min(listDrama.length, (i + 1) * 30)}',
                              ),
                            )
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 14.w,
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  for (int sizei = 0; sizei < size; sizei++)
                    Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 11.w,
                      spacing: 13.w,
                      children: [
                        for (int i = sizei * 30;
                            i < min(sizei * 30 + 30, listDrama.length);
                            i++)
                          GestureDetector(
                              onTap: () {
                                widget.callback(i);
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 46.w,
                                    height: 46.w,
                                    decoration: BoxDecoration(
                                      // 设置背景颜色，对应 CSS 中的 rgba(47, 47, 59, 1)
                                      color:
                                          const Color.fromRGBO(47, 47, 59, 1),
                                      // 设置圆角半径为 4 像素，对应 CSS 中的 border - radius: 4px;
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(child: Text('${i + 1}')),
                                  ),
                                  if (i == widget.currentIndex)
                                    Positioned(
                                      bottom: 2.w,
                                      left: 4.w,
                                      child: AudioWaveAnimation(
                                        size: 13.w,
                                        color: Color.fromRGBO(255, 45, 111, 1),
                                        barCount: 4,
                                      ),
                                    ),
                                  if (listDrama[i].locking == 1)
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Image.asset(
                                        'assets/images/locking.png',
                                        width: 20.w,
                                      ),
                                    ),
                                  if (listDrama[i].locking == 1)
                                    Positioned(
                                      left: 4.w,
                                      bottom: 4.w,
                                      child: Image.asset(
                                        'assets/images/jinbi.png',
                                        width: 13.w,
                                      ),
                                    ),
                                ],
                              ))
                      ],
                    )
                ]),
              ),
            ],
          ),
        ));
  }
}
