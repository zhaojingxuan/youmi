import 'vip.dart';

class UserRights {
  int? xp;
  int? energy;
  Vip? vip;

  UserRights({this.xp, this.energy, this.vip});

  factory UserRights.fromJson(Map<String, dynamic> json) => UserRights(
        xp: json['xp'] as int?,
        energy: json['energy'] as int?,
        vip: json['vip'] == null
            ? null
            : Vip.fromJson(json['vip'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'xp': xp,
        'energy': energy,
        'vip': vip?.toJson(),
      };
}
