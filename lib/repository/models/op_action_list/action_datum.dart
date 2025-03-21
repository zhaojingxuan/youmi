class ActionDatum {
  int? dramaId;
  int? epId;
  int? type;
  int? epSort;
  String? dramaName;
  String? dramaUrl;

  ActionDatum({
    this.dramaId,
    this.epId,
    this.type,
    this.epSort,
    this.dramaName,
    this.dramaUrl,
  });

  factory ActionDatum.fromJson(Map<String, dynamic> json) => ActionDatum(
        dramaId: json['drama_id'] as int?,
        epId: json['ep_id'] as int?,
        type: json['type'] as int?,
        epSort: json['ep_sort'] as int?,
        dramaName: json['drama_name'] as String?,
        dramaUrl: json['drama_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'drama_id': dramaId,
        'ep_id': epId,
        'type': type,
        'ep_sort': epSort,
        'drama_name': dramaName,
        'drama_url': dramaUrl,
      };
}
