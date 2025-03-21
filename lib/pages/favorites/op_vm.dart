import 'package:flutter/material.dart';
import 'package:youmi/repository/api.dart';
import 'package:youmi/repository/models/history_list/history.dart';
import 'package:youmi/repository/models/op_action_list/action_datum.dart';

class OpVm with ChangeNotifier {
  List<ActionDatum> likeList = [];
  int _pageLike = 1;
  List<ActionDatum> collectList = [];
  int _pageCollect = 1;

  Future<bool> getLikeList(bool isMore) async {
    if (isMore) {
      _pageLike++;
    } else {
      _pageLike = 1;
    }

    var list = ((await Api.instance.getOpActionList(type: '0', page: _pageLike))
            .data ??
        []);
    if (!isMore) {
      likeList = [];
    }
    likeList = [...likeList, ...list];
    if (hasListeners) {
      notifyListeners();
    }

    return list.isNotEmpty;
  }

  Future<bool> getCollectList(bool isMore) async {
    if (isMore) {
      _pageCollect++;
    } else {
      _pageCollect = 1;
      collectList = [];
    }
    var list =
        ((await Api.instance.getOpActionList(type: '1', page: _pageCollect))
                .data ??
            []);
    collectList = [...collectList, ...list];
    if (hasListeners) {
      notifyListeners();
    }
    return list.isNotEmpty;
  }
}
