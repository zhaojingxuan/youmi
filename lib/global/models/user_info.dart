class UserInfo {
  String? userName;
  String? userAccount;
  num? userLevel;
  num? userXp;
  num? coins;
  num? vouchers;
  num? tickes;
  num? tickesConv;
  num? energy;
  String? firstActTime;
  String? lastLoginTime;
  num? userStatus;
  String? language;
  String? platform;
  String? deviceModel;
  String? osVersion;
  String? displayW;
  String? displayH;
  String? cpuAbis;
  String? networkType;
  String? versionName;
  String? versionCode;
  String? timeZone;
  String? countryCode;
  String? userCode;
  String? recoverEnergyTime;

  UserInfo(
      {this.userName,
      this.userAccount,
      this.userLevel,
      this.userXp,
      this.coins,
      this.vouchers,
      this.tickes,
      this.tickesConv,
      this.energy,
      this.firstActTime,
      this.lastLoginTime,
      this.userStatus,
      this.language,
      this.platform,
      this.deviceModel,
      this.osVersion,
      this.displayW,
      this.displayH,
      this.cpuAbis,
      this.networkType,
      this.versionName,
      this.versionCode,
      this.timeZone,
      this.countryCode,
      this.userCode,
      this.recoverEnergyTime});

  UserInfo copyWith(
          {String? userName,
          String? userAccount,
          num? userLevel,
          num? userXp,
          num? coins,
          num? vouchers,
          num? tickes,
          num? tickesConv,
          num? energy,
          String? firstActTime,
          String? lastLoginTime,
          num? userStatus,
          String? language,
          String? platform,
          String? deviceModel,
          String? osVersion,
          String? displayW,
          String? displayH,
          String? cpuAbis,
          String? networkType,
          String? versionName,
          String? versionCode,
          String? timeZone,
          String? countryCode,
          String? userCode,
          String? recoverEnergyTime}) =>
      UserInfo(
          userName: userName ?? this.userName,
          userAccount: userAccount ?? this.userAccount,
          userLevel: userLevel ?? this.userLevel,
          userXp: userXp ?? this.userXp,
          coins: coins ?? this.coins,
          vouchers: vouchers ?? this.vouchers,
          tickes: tickes ?? this.tickes,
          tickesConv: tickesConv ?? this.tickesConv,
          energy: energy ?? this.energy,
          firstActTime: firstActTime ?? this.firstActTime,
          lastLoginTime: lastLoginTime ?? this.lastLoginTime,
          userStatus: userStatus ?? this.userStatus,
          language: language ?? this.language,
          platform: platform ?? this.platform,
          deviceModel: deviceModel ?? this.deviceModel,
          osVersion: osVersion ?? this.osVersion,
          displayW: displayW ?? this.displayW,
          displayH: displayH ?? this.displayH,
          cpuAbis: cpuAbis ?? this.cpuAbis,
          networkType: networkType ?? this.networkType,
          versionName: versionName ?? this.versionName,
          versionCode: versionCode ?? this.versionCode,
          timeZone: timeZone ?? this.timeZone,
          countryCode: countryCode ?? this.countryCode,
          userCode: userCode ?? this.userCode,
          recoverEnergyTime: recoverEnergyTime ?? this.recoverEnergyTime);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["user_name"] = userName;
    map["user_account"] = userAccount;
    map["user_level"] = userLevel;
    map["user_xp"] = userXp;
    map["coins"] = coins;
    map["vouchers"] = vouchers;
    map["tickes"] = tickes;
    map["tickes_conv"] = tickesConv;
    map["energy"] = energy;
    map["first_act_time"] = firstActTime;
    map["last_login_time"] = lastLoginTime;
    map["user_status"] = userStatus;
    map["language"] = language;
    map["platform"] = platform;
    map["device_model"] = deviceModel;
    map["os_version"] = osVersion;
    map["display_w"] = displayW;
    map["display_h"] = displayH;
    map["cpu_abis"] = cpuAbis;
    map["network_type"] = networkType;
    map["version_name"] = versionName;
    map["version_code"] = versionCode;
    map["time_zone"] = timeZone;
    map["country_code"] = countryCode;
    map["user_code"] = userCode;
    map["recover_energy_time"] = recoverEnergyTime;
    return map;
  }

  UserInfo.fromJson(dynamic json) {
    userName = json["user_name"];
    userAccount = json["user_account"];
    userLevel = json["user_level"];
    userXp = json["user_xp"];
    coins = json["coins"];
    vouchers = json["vouchers"];
    tickes = json["tickes"];
    tickesConv = json["tickes_conv"];
    energy = json["energy"];
    firstActTime = json["first_act_time"];
    lastLoginTime = json["last_login_time"];
    userStatus = json["user_status"];
    language = json["language"];
    platform = json["platform"].toString();
    deviceModel = json["device_model"];
    osVersion = json["os_version"];
    displayW = json["display_w"];
    displayH = json["display_h"];
    cpuAbis = json["cpu_abis"];
    networkType = json["network_type"];
    versionName = json["version_name"];
    versionCode = json["version_code"];
    timeZone = json["time_zone"];
    countryCode = json["country_code"];
    userCode = json["user_code"];
    recoverEnergyTime = json["recover_energy_time"];
  }
}
