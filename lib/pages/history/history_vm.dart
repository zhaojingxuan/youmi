import 'package:flutter/material.dart';
import 'package:youmi/repository/api.dart';
import 'package:youmi/repository/models/history_list/history.dart';

class HistoryVm with ChangeNotifier {
  List<History>? historyList;

  Future getUserHistory() async {
    historyList = await Api.instance.userHistory();
    if (hasListeners) {
      notifyListeners();
    }
  }
}
