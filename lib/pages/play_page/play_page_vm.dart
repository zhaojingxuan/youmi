import 'package:flutter/material.dart';
import 'package:youmi/common_ui/video_player/types/video_item_info_t.dart';
import 'package:youmi/repository/api.dart';
import 'package:youmi/repository/models/drama_list/drama_item.dart';

class PlayPageVm with ChangeNotifier {
  List<DramaItem> listDrama = [];
  String dramaName = '';
  int total = 0;
  int currentIndex = 0;
  VideoItemInfoT? videoItemInfoT;

  Future getDramaList({required int dramaId}) async {
    listDrama = [];
    for (int page = 1;; page++) {
      var res = await Api.instance
          .getDramaList(dramaId: dramaId, page: page.toString());
      var list = res.list ?? [];
      if (list.isEmpty) {
        break;
      }
      listDrama = [...listDrama, ...list];
      dramaName = res.dramaName ?? '';
      total = res.total ?? 0;
      if (listDrama.length >= total) {
        break;
      }
    }
    if (hasListeners) {
      notifyListeners();
    }
  }

  set currentIndexValue(int value) {
    currentIndex = value;
    if (hasListeners) {
      notifyListeners();
    }
  }

  setDramaListItem({required int index, required Map<String, dynamic> obj}) {
    listDrama[index] =
        DramaItem.fromJson({...listDrama[index].toJson(), ...obj});
    if (hasListeners) {
      notifyListeners();
    }
  }
}
