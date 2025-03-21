import 'history.dart';

class HistoryList {
  List<History>? data;

  HistoryList({this.data});

  factory HistoryList.fromJson(Map<String, dynamic> json) => HistoryList(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => History.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
