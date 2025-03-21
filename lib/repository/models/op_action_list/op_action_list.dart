import 'action_datum.dart';

class OpActionList {
  int? total;
  int? totalPage;
  List<ActionDatum>? data;

  OpActionList({this.total, this.totalPage, this.data});

  factory OpActionList.fromJson(Map<String, dynamic> json) => OpActionList(
        total: json['total'] as int?,
        totalPage: json['totalPage'] as int?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => ActionDatum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'totalPage': totalPage,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
