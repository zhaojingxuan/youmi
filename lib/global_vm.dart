import 'package:flutter/material.dart';
import 'package:youmi/repository/api.dart';
import 'package:youmi/repository/models/me_userinfo.dart';
import 'package:youmi/repository/models/user_rights/user_rights.dart';
import 'package:youmi/utils/sp_key_constants.dart';
import 'package:youmi/utils/sp_utils.dart';

class GlobalVm with ChangeNotifier {
  MeUserinfo? meUserinfo;
  UserRights? userRights;
  bool _automaticRelease = false;

  GlobalVm() {
    SpUtils.getBool(SPKEYConstants.SP_AutomaticRelease).then((value) {
      _automaticRelease = value ?? false;
      notifyListeners();
    });
    // updateUserInfo();
  }

  Future getMeUserInfo() async {
    meUserinfo = await Api.instance.meUserInfo();
    if (hasListeners) {
      notifyListeners();
    }
  }

  Future getUserRights() async {
    userRights = await Api.instance.userRights();
    if (hasListeners) {
      notifyListeners();
    }
  }

  Future updateUserInfo() async {
    await getMeUserInfo();
    await getUserRights();
  }

  bool get automaticRelease {
    return _automaticRelease;
  }

  set automaticRelease(bool value) {
    _automaticRelease = value;
    SpUtils.saveBool(SPKEYConstants.SP_AutomaticRelease, value);
    notifyListeners();
  }
}
