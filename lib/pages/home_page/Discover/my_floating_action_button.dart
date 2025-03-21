import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youmi/pages/home_page/Discover/discover_vm.dart';

class Myfloatingactionbutton extends StatelessWidget {
  final ScrollController scrollController;

  const Myfloatingactionbutton({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Selector<DiscoverVm, bool>(
        selector: (_, vm) => vm.showScrollToTopButton,
        builder: (context, showScrollToTopButton, child) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300), // 动画时长
            curve: Curves.easeInOut,
            width: showScrollToTopButton ? 26.w : 0,
            height: showScrollToTopButton ? 28.w : 0,
            child: GestureDetector(
              onTap: _scrollToTop,
              child: Image.asset(
                "assets/images/totop.png",
              ),
            ),
          );
        });
  }

  Future<void> _scrollToTop() async {
    await scrollController.animateTo(
      -10, // 滚动到顶部（偏移量为 0）
      duration: const Duration(milliseconds: 500), // 动画时长
      curve: Curves.easeInOut, // 动画曲线
    );
  }
}
