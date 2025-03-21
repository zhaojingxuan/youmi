import 'package:flutter/material.dart';

class HomeTabShareDataVm extends ChangeNotifier {
  int showTabIndex;
  double tabHeight;

  HomeTabShareDataVm({required this.showTabIndex, required this.tabHeight});

  void setShowTabIndex(int index) {
    showTabIndex = index;
    notifyListeners();
  }

  void setTabHeight(double height) {
    tabHeight = height;
    notifyListeners();
  }
}
