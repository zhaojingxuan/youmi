import 'sig_in_prop.dart';

class Day {
  int? day;
  int? type;
  List<SigInProp>? sigInProp;

  Day({this.day, this.type, this.sigInProp});

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        day: json['day'] as int?,
        type: json['type'] as int?,
        sigInProp: (json['sig_in_prop'] as List<dynamic>?)
            ?.map((e) => SigInProp.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'day': day,
        'type': type,
        'sig_in_prop': sigInProp?.map((e) => e.toJson()).toList(),
      };
}
