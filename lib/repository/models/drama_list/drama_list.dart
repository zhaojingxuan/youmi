import 'drama_item.dart';

class DramaList {
  String? dramaName;
  int? totalPage;
  int? total;
  int? energy;
  List<DramaItem>? list;
  int? pageNumber;

  DramaList({
    this.dramaName,
    this.totalPage,
    this.total,
    this.energy,
    this.list,
    this.pageNumber,
  });

  factory DramaList.fromJson(Map<String, dynamic> json) => DramaList(
        dramaName: json['drama_name'] as String?,
        totalPage: json['totalPage'] as int?,
        total: json['total'] as int?,
        energy: json['energy'] as int?,
        list: (json['list'] as List<dynamic>?)
            ?.map((e) => DramaItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        pageNumber: json['pageNumber'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'drama_name': dramaName,
        'totalPage': totalPage,
        'total': total,
        'energy': energy,
        'list': list?.map((e) => e.toJson()).toList(),
        'pageNumber': pageNumber,
      };
}
