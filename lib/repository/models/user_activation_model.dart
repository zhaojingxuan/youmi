import 'package:youmi/global/models/user_info.dart';

class UserActivationModel {
  String? token;
  String? accessToken;
  UserInfo? userInfo;

  UserActivationModel({
    this.token,
    this.accessToken,
    this.userInfo,
  });

  UserActivationModel.fromJson(Map<String, dynamic>? json) {
    token = json?['token'];
    accessToken = json?['accessToken'];
    userInfo = UserInfo.fromJson(json?['userInfo']);
  }
}
