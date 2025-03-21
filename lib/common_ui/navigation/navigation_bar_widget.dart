import 'package:flutter/material.dart';
import 'package:youmi/common_ui/navigation/Animation_click.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PagesLabelsIconsActiveIcons {
  final Widget page;
  final String label;
  final Widget icon;
  final Widget activeIcon;

  const PagesLabelsIconsActiveIcons({
    required this.page,
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}

// ignore: must_be_immutable
class NavigationBarWidget extends StatefulWidget {
  NavigationBarWidget({
    super.key,
    required this.pagesLabelsIconsActiveIcons,
    this.currentIndex,
    this.onTabChange,
  });
  final List<PagesLabelsIconsActiveIcons> pagesLabelsIconsActiveIcons;
  int? currentIndex;
  final ValueChanged<int>? onTabChange;

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: IndexedStack(
          index: widget.currentIndex ?? 0,
          children:
              widget.pagesLabelsIconsActiveIcons.map((i) => i.page).toList(),
        )),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(fontSize: 14.sp, color: Colors.black),
            unselectedLabelStyle:
                TextStyle(fontSize: 12.sp, color: Colors.blueGrey),
            currentIndex: widget.currentIndex ?? 0,
            items: _barItemList(),
            onTap: (index) {
              widget.currentIndex = index;
              widget.onTabChange?.call(index);
              setState(() {});
            },
          ),
        ));
  }

  List<BottomNavigationBarItem> _barItemList() {
    return widget.pagesLabelsIconsActiveIcons
        .map((i) => BottomNavigationBarItem(
            label: i.label,
            activeIcon: AnimationClick(builder: (context) {
              return i.activeIcon;
            }),
            icon: i.icon))
        .toList();
  }
}
