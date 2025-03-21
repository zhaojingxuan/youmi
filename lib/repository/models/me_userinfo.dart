class MeUserinfo {
  int? id;
  String? userName;
  String? userAccount;
  int? userLevel;
  dynamic userImage;
  int? userXp;
  int? coins;
  int? energy;
  int? maxEnergy;
  int? autoUnlock;
  int? autoCoin;
  bool? vip;
  int? isBind;
  int? firstActTime;
  String? type;
  int? logType;
  int? adUnlockNumber;
  int? adUserUnlockNumber;

  MeUserinfo({
    this.id,
    this.userName,
    this.userAccount,
    this.userLevel,
    this.userImage,
    this.userXp,
    this.coins,
    this.energy,
    this.maxEnergy,
    this.autoUnlock,
    this.autoCoin,
    this.vip,
    this.isBind,
    this.firstActTime,
    this.type,
    this.logType,
    this.adUnlockNumber,
    this.adUserUnlockNumber,
  });

  factory MeUserinfo.fromJson(Map<String, dynamic> json) => MeUserinfo(
        id: json['id'] as int?,
        userName: json['user_name'] as String?,
        userAccount: json['user_account'] as String?,
        userLevel: json['user_level'] as int?,
        userImage: json['user_image'] as dynamic,
        userXp: json['user_xp'] as int?,
        coins: json['coins'] as int?,
        energy: json['energy'] as int?,
        maxEnergy: json['max_energy'] as int?,
        autoUnlock: json['auto_unlock'] as int?,
        autoCoin: json['auto_coin'] as int?,
        vip: json['vip'] as bool?,
        isBind: json['is_bind'] as int?,
        firstActTime: json['first_act_time'] as int?,
        type: json['type'] as String?,
        logType: json['log_type'] as int?,
        adUnlockNumber: json['ad_unlock_number'] as int?,
        adUserUnlockNumber: json['ad_user_unlock_number'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_name': userName,
        'user_account': userAccount,
        'user_level': userLevel,
        'user_image': userImage,
        'user_xp': userXp,
        'coins': coins,
        'energy': energy,
        'max_energy': maxEnergy,
        'auto_unlock': autoUnlock,
        'auto_coin': autoCoin,
        'vip': vip,
        'is_bind': isBind,
        'first_act_time': firstActTime,
        'type': type,
        'log_type': logType,
        'ad_unlock_number': adUnlockNumber,
        'ad_user_unlock_number': adUserUnlockNumber,
      };
}
