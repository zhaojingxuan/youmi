import 'package:flutter/material.dart';
import 'package:youmi/repository/api.dart';
import 'package:youmi/repository/models/store_sign_in/day.dart';
import 'package:youmi/repository/models/store_sign_in/store_sign_in.dart';
import 'package:youmi/repository/models/store_vip/store_vip.dart';
import 'package:youmi/repository/models/vip_task_list/vip_task_list.dart';

class MeVm with ChangeNotifier {
  List<StoreVip> listStoreVip = [];
  StoreSignIn? storeSignIn;
  VipTaskList? vipTaskList;

  Day? get today {
    if (storeSignIn?.isSignIn == false) {
      for (var i = 0; i < (storeSignIn?.day?.length ?? 0); i++) {
        if (storeSignIn?.day?[i].type == 0) {
          return storeSignIn?.day?[i];
        }
      }
    }
    return null;
  }

  GlobalKey todayKey = GlobalKey();
  GlobalKey headerjbKey = GlobalKey();

  Future getUserStoreVip() async {
    listStoreVip = (await Api.instance.userStoreVip());
    if (hasListeners) {
      notifyListeners();
    }
  }

  Future vipStoreSignIn() async {
    storeSignIn = (await Api.instance.vipStoreSignIn());
    if (hasListeners) {
      notifyListeners();
    }
  }

  Future userSignAction() async {
    await Api.instance.userSignAction();
    await getUserStoreVip();
    await vipStoreSignIn();
  }

  Future getVipTaskList() async {
    vipTaskList = await Api.instance.vipTaskList();
    if (hasListeners) {
      notifyListeners();
    }
  }
}
