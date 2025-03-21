import 'dart:io';
import 'package:youmi/utils/sp_key_constants.dart';
import 'package:youmi/utils/sp_utils.dart';

class GlobalInfo {
  GlobalInfo._();

  static GlobalInfo info = GlobalInfo._();

  String version_name = '短剧视频app';
  String version_code = 'v1';

  String? _token = "";
  String? getToken() {
    return _token;
  }

  void setToken(String? s) {
    _token = s;
    // _token =
    //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjbGlwZHJhbWFfc2VydmljZSIsImF1ZCI6ImNsaXBkcmFtYV9jbGllbnQiLCJpYXQiOjE3MzAyOTgwNzgsIm5iZiI6MTczMDI5ODA3OCwiZXhwIjoiMzYwMCIsInVpZCI6Nn0.4Z9kFQ0DRxOZ9PNgZfr49Ue_-BNbmMovxmfP986357I";
  }

  String? _accessToken = "";

  String? getAccessToken() {
    return _accessToken;
  }

  void setAccessToken(String? s) {
    _accessToken = s;
  }

  // // 检查当前是否已登录
  // bool checkLogin() {
  //   return _userInfo == null || StringUtils.isEmpty(_userInfo?.userName);
  // }

  String getDeviceBrand() {
    return Platform.isAndroid ? 'Android' : 'Ios';
  }

  String _languageCode = '';

  String getLanguageCode() {
    return _languageCode;
  }

  Future setLanguageCode(String l) async {
    _languageCode = l;
    await SpUtils.saveString(SPKEYConstants.SP_LanguageCode, l);
  }

  List<Map<String, String>> canUseLanguageList = [
    {'en': 'English (English)'},
    {'pt': 'Portuguese (Portugués)'},
  ];

  List<String> get canUseLanguageListCode =>
      canUseLanguageList.expand((map) => map.keys).toList();

  List<String> get showUseLanguageListLabel =>
      canUseLanguageList.expand((map) => map.values).toList();

  Map<String, String> get nowLanguage {
    for (int i = 0; i < canUseLanguageList.length; i++) {
      if (canUseLanguageList[i].keys.toList().contains(getLanguageCode())) {
        return canUseLanguageList[i];
      }
    }
    return canUseLanguageList[0];
  }
}
