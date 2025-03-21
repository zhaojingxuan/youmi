import 'package:flutter/material.dart';
import 'package:youmi/repository/api.dart';
import 'package:youmi/repository/models/index_sale/item_sale.dart';

class ShortsVm with ChangeNotifier {
  List<ItemSale> listSale = [];

  Future getListSale() async {
    listSale = (await Api.instance.getIndexSale()).data ?? [];
    if (hasListeners) {
      notifyListeners();
    }
  }
}
