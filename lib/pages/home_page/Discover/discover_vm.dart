import 'package:flutter/material.dart';
import 'package:youmi/repository/api.dart';
import 'package:youmi/repository/models/drama_data/drama_datum.dart';
import 'package:youmi/repository/models/drama_data/drama_data.dart';
import 'package:youmi/repository/models/youmi_home_model/youmi_banner.dart';
import 'package:youmi/repository/models/youmi_home_model/youmi_home_model.dart';
import 'package:youmi/repository/models/youmi_home_model/youmi_home_module.dart';

class DiscoverVm with ChangeNotifier {
  YoumiHomeModel? youmiHomeData;

  List<YoumiBanner>? bannerList;
  List<YoumiHomeModule>? modulesList;

  int _pageCount = 1;
  List<DramaDatum>? datumList;

  Future getHomeData() async {
    youmiHomeData = await Api.instance.youmiHome();
    bannerList = youmiHomeData?.banner;

    youmiHomeData?.modules
        ?.sort((a, b) => (a.store?.compareTo(b.store ?? 0) ?? 0));
    modulesList = youmiHomeData?.modules;
    if (hasListeners) {
      notifyListeners();
    }
  }

  ///获取数据
  Future<bool> getDramaData([bool loadMore = false]) async {
    if (loadMore) {
      _pageCount += 1;
    } else {
      _pageCount = 1;
    }
    DramaData resData = await Api.instance.dramaData(_pageCount);

    datumList = loadMore
        ? [...datumList ?? [], ...resData.data ?? []]
        : resData.data ?? [];
    if (hasListeners) {
      notifyListeners();
    }
    return (resData.data ?? []).isNotEmpty;
  }

  bool showScrollToTopButton = false;
  void setShowScrollToTopButton(bool show) {
    showScrollToTopButton = show;
    notifyListeners();
  }
}
