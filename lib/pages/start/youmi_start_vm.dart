import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:uuid/uuid.dart';
import 'package:youmi/global/global_info.dart';
import 'package:youmi/global/models/user_info.dart';
import 'package:youmi/repository/api.dart';
import 'package:youmi/repository/models/user_activation_model.dart';
import 'package:youmi/utils/sp_key_constants.dart';
import 'package:youmi/utils/device_info.dart';
import 'package:youmi/utils/sp_utils.dart';
import 'package:youmi/utils/string_utils.dart';

class YoumiStartVm with ChangeNotifier {
  UserInfo? _userInfo;

  UserInfo? getUserInfo() {
    return _userInfo;
  }

  void _setUser(UserInfo? userInfo) {
    _userInfo = userInfo;
    if (hasListeners) {
      notifyListeners();
    }
  }

  Future userActivation() async {
    // 获取当前系统的 Locale 信息
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    // 从 Locale 中提取国家代码
    final countryCode = locale.countryCode ?? '';
    final languageCode = locale.languageCode;
    var deviceInfo = await DeviceInfo.getDeviceInfo();

    String? uuidV1 = await SpUtils.getString(SPKEYConstants.SP_Uuid);
    if (StringUtils.isEmpty(uuidV1)) {
      uuidV1 = Uuid().v1();
      SpUtils.saveString(SPKEYConstants.SP_Uuid, uuidV1);
    }

    // deviceInfo["id"] = '${DateTime.now().millisecondsSinceEpoch}';
    // uuidV1 = '${DateTime.now().millisecondsSinceEpoch}';
    // deviceInfo["fingerprint"] = '${DateTime.now().millisecondsSinceEpoch}';

    // debugPrint('deviceInfo： id：${StringUtils.toMd5(deviceInfo["id"])}');
    // debugPrint('deviceInfo： uuidV1：${StringUtils.toMd5(uuidV1 ?? '')}');
    // debugPrint(
    //     'deviceInfo： fingerprint：${StringUtils.toMd5(deviceInfo["fingerprint"])}');

    var rbstdc = '';
    if (deviceInfo["platform"] == 1) {
      rbstdc = StringUtils.str2base64(
          '${(deviceInfo["id"])},${((uuidV1 ?? ''))},${((deviceInfo["fingerprint"]))}');
    } else {
      rbstdc = StringUtils.str2base64('${deviceInfo["identifierForVendor"]}');
    }
    debugPrint('deviceInfo： rbstdc：$rbstdc:${deviceInfo["platform"]}');

    var userActivationRequest = {
      "device_brand": deviceInfo["brand"],
      "country_code": countryCode,
      "device_model": deviceInfo["model"],
      "network_type": await DeviceInfo.checkNetworkAndType(),
      "os_version": deviceInfo['version.release'],
      "platform": deviceInfo["platform"],
      "rbstdc": rbstdc,
      "sys_lang": languageCode,
      "time_zone": DeviceInfo.getTimeZone(),
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      "version_name": GlobalInfo.info.version_name,
      "version_code": GlobalInfo.info.version_code,
    };

    userActivationRequest['sign'] = StringUtils.signData(userActivationRequest,
        '7ee6435d86e82eca1046eea5a81a6c1d1919ad88c3669e7adbbb3a608f6cfd42');

    showToast('userActivationRequest：${userActivationRequest['sign']}');

    UserActivationModel userActivationModel =
        await Api.instance.userActivation(userActivationRequest);

    _setUser(userActivationModel.userInfo);
    GlobalInfo.info.setToken(userActivationModel.token);
    GlobalInfo.info.setAccessToken(userActivationModel.accessToken);
  }
}
